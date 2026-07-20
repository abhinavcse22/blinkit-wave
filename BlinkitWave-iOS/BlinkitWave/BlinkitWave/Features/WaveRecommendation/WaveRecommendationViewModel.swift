import Foundation
import Observation

/// ViewModel for Checkout and Wave Recommendations, calling the Smart Wave Engine.
@Observable
final class WaveRecommendationViewModel {
    // MARK: - State
    
    var currentUser: User?
    var activeCart: Cart?
    var recommendation: WaveRecommendation?
    var selectedOption: DeliveryOption?
    var walletBalance: Double = 0.0

    /// The user's chosen "when do you need it" deadline — the single source of
    /// truth the Smart Checkout section evaluates against.
    var deliveryDeadline = Date(timeIntervalSinceNow: 7200.0) // Default 2 hours

    var isCheckingOut = false
    var checkedOutOrderID: String?

    // MARK: - Dependencies

    private let cartRepository = AppContainer.shared.cartRepository
    private let orderRepository = AppContainer.shared.orderRepository
    private let userRepository = AppContainer.shared.userRepository
    private let walletRepository = AppContainer.shared.walletRepository
    private let waveRepository = AppContainer.shared.waveRepository

    private let engine = SmartWaveEngine()

    init() {}

    // MARK: - Actions

    /// Loads user/cart and calls the Smart Wave Engine to compute recommendations.
    func loadRecommendation() async {
        do {
            let user = try await userRepository.fetchCurrentUser()
            self.currentUser = user

            let cart = try await cartRepository.fetchCart()
            self.activeCart = cart

            let wallet = try await walletRepository.fetchWallet()
            self.walletBalance = wallet.balance

            // Fetch nearby orders for matching
            let nearby = OrderFixtures.all.filter { $0.status == .waveAssembling }

            // Run engine
            let result = engine.evaluate(
                user: user,
                cart: cart,
                deadline: deliveryDeadline,
                nearbyOrders: nearby,
                riderAvailable: true,
                inventoryAvailable: true,
                currentTime: Date()
            )

            self.recommendation = result
            self.selectedOption = result.primaryRecommendation.recommendedOption
        } catch {
            print("Failed to compute wave recommendations: \(error)")
        }
    }

    /// Submits the final order checkout transaction.
    func checkout() async {
        guard let user = currentUser, let cart = activeCart, let option = selectedOption, let rec = recommendation else { return }
        isCheckingOut = true
        
        do {
            let orderID = "ORD-WAVE-\(Int.random(in: 10000...99999))"
            let subtotal = cart.items.reduce(0.0) { sum, item in
                guard let product = item.product else { return sum }
                return sum + (product.price * Double(item.quantity))
            }
            
            let deliveryFee = rec.estimatedDeliveryFee
            let walletDiscount: Double
            
            // Smart Wallet adjustments
            if case .smartWallet = option {
                let missingAmount = max(0.0, EngineConfiguration.defaultConfiguration.freeDeliveryThreshold - subtotal)
                _ = try await walletRepository.depositFunds(amount: missingAmount, description: "Deposit buffer for free delivery wave")
                walletDiscount = 0.0
            } else {
                walletDiscount = 0.0
            }
            
            let total = subtotal + deliveryFee - walletDiscount
            
            let order = Order(
                id: orderID,
                user: user,
                items: cart.items,
                deliveryAddress: user.addresses[0],
                orderDate: Date(),
                deliveryDeadline: deliveryDeadline,
                deliveryOption: option,
                status: .placed,
                subtotal: subtotal,
                deliveryFee: deliveryFee,
                walletDiscount: walletDiscount,
                totalAmount: total
            )
            
            // Dedect wallet balance if wallet has funds or debit
            _ = try await walletRepository.debitFunds(amount: total, description: "Checkout Payment for Order \(orderID)")
            
            // Persist order
            _ = try await orderRepository.placeOrder(order)
            
            // Save wave references if joined
            if case .liveWave(let waveID) = option {
                _ = try await waveRepository.joinWave(order: order, waveID: waveID)
            } else if case .scheduledWave(let slotID) = option {
                let newWave = Wave(
                    id: "WAVE-\(slotID)",
                    type: .scheduled,
                    scheduledDispatchTime: rec.predictedWaveSlot.startTime,
                    centroidLatitude: user.addresses[0].latitude,
                    centroidLongitude: user.addresses[0].longitude
                )
                _ = try await waveRepository.createWave(newWave)
                _ = try await waveRepository.joinWave(order: order, waveID: newWave.id)
            }
            
            // Increment savings metrics
            if rec.estimatedSavings > 0 {
                _ = try await userRepository.updateUserSavings(savingsAmount: rec.estimatedSavings)
            }
            
            // Clear checkout cart
            _ = try await cartRepository.clearCart()
            
            self.checkedOutOrderID = orderID
        } catch {
            print("Checkout failed: \(error)")
        }
        
        isCheckingOut = false
    }
}
