import Foundation
import Observation

/// ViewModel for order delivery tracking, simulating tracking statuses.
@Observable
final class TrackingViewModel {
    // MARK: - State
    
    var order: Order?
    var currentStepIndex = 0
    var isLoading = false
    
    let trackingSteps = [
        "Waiting for Wave",
        "Wave Formed",
        "Driver Assigned",
        "Nearby (1 Stop Away)",
        "Delivered"
    ]

    // MARK: - Dependencies
    
    private let orderRepository = AppContainer.shared.orderRepository

    init() {}

    // MARK: - Actions
    
    /// Loads details of the placed order.
    func loadOrder(byID id: String) async {
        isLoading = true
        do {
            let found = try await orderRepository.fetchOrder(byID: id)
            self.order = found
            updateStep(for: found?.status ?? .placed)
        } catch {
            print("Failed to load tracking order: \(error)")
        }
        isLoading = false
    }

    /// Simulates progression of order tracking steps for demonstration/hackathon purposes.
    func simulateProgress() async {
        guard let order = order else { return }
        
        // Progress step index
        if currentStepIndex < trackingSteps.count - 1 {
            currentStepIndex += 1
            let nextStatus: OrderStatus
            switch currentStepIndex {
            case 1: nextStatus = .waveAssembling
            case 2: nextStatus = .waveConfirmed
            case 3: nextStatus = .dispatched
            case 4: nextStatus = .delivered
            default: nextStatus = .placed
            }
            
            do {
                _ = try await orderRepository.updateOrderStatus(orderID: order.id, status: nextStatus)
                self.order = try await orderRepository.fetchOrder(byID: order.id)
            } catch {
                print("Failed to update status: \(error)")
            }
        }
    }

    // MARK: - Helpers
    
    private func updateStep(for status: OrderStatus) {
        switch status {
        case .placed: currentStepIndex = 0
        case .waveAssembling: currentStepIndex = 1
        case .waveConfirmed: currentStepIndex = 2
        case .dispatched: currentStepIndex = 3
        case .delivered: currentStepIndex = 4
        case .cancelled: currentStepIndex = 0
        }
    }
}
