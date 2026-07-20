import Foundation
import Observation

/// ViewModel for Cart management, tracking items and totals.
@Observable
final class CartViewModel {
    // MARK: - State
    
    var cart: Cart?
    var isLoading = false
    var freeDeliveryProgress = 0.0
    var freeDeliveryThreshold = 150.0

    // MARK: - Dependencies
    
    private let cartRepository = AppContainer.shared.cartRepository
    private let productRepository = AppContainer.shared.productRepository

    init() {
        self.freeDeliveryThreshold = EngineConfiguration.defaultConfiguration.freeDeliveryThreshold
    }

    // MARK: - Actions
    
    /// Loads the active cart.
    func loadCart() async {
        isLoading = true
        do {
            let activeCart = try await cartRepository.fetchCart()
            self.cart = activeCart
            updateProgress(for: activeCart)
        } catch {
            print("Failed to load cart: \(error)")
        }
        isLoading = false
    }

    /// Modifies product item quantities.
    func updateQuantity(for item: CartItem, delta: Int) async {
        guard let product = item.product else { return }
        do {
            let newQty = item.quantity + delta
            if newQty <= 0 {
                _ = try await cartRepository.removeItem(productID: product.id)
            } else {
                _ = try await cartRepository.addItem(product: product, quantity: delta)
            }
            // Reload cart status
            let activeCart = try await cartRepository.fetchCart()
            self.cart = activeCart
            updateProgress(for: activeCart)
        } catch {
            print("Failed to update cart quantity: \(error)")
        }
    }

    /// Clears the cart.
    func clearCart() async {
        do {
            let activeCart = try await cartRepository.clearCart()
            self.cart = activeCart
            updateProgress(for: activeCart)
        } catch {
            print("Failed to clear cart: \(error)")
        }
    }

    // MARK: - Helpers
    
    private func updateProgress(for activeCart: Cart) {
        let subtotal = activeCart.items.reduce(0.0) { sum, item in
            guard let product = item.product else { return sum }
            return sum + (product.price * Double(item.quantity))
        }
        self.freeDeliveryProgress = min(1.0, subtotal / freeDeliveryThreshold)
    }
}
