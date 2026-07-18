import Foundation

/// Defines the economic outcome of aggregating a collection of neighbor checkout orders.
struct BatchOptimizationResult: Codable, Sendable, Hashable {
    /// Combined value in Rupees of the user's cart and matched neighborhood orders.
    var combinedValue: Double
    
    /// Flag indicating whether the combined value reaches the free delivery threshold.
    var isEligibleForFreeDelivery: Bool
    
    /// Billed delivery charges saved in Rupees through cluster aggregation.
    var estimatedSavings: Double
    
    /// The neighbor orders grouped within the optimization window.
    var ordersInBatch: [Order]
}

/// Pure component responsible for evaluating combined basket values and free delivery eligibility.
struct BatchOptimizer {
    /// Injected business configurations.
    let configuration: EngineConfiguration

    /// Bundles a shopping cart with nearby orders to compute batch-level financials.
    /// - Parameters:
    ///   - cart: The primary checkout cart.
    ///   - matchedOrders: Nearby orders clustered within matching radius.
    /// - Returns: Calculated economics result.
    func optimize(cart: Cart, matchedOrders: [Order]) -> BatchOptimizationResult {
        // Calculate cart subtotal directly in optimizer to keep logic in the Engine layer.
        let cartTotal = cart.items.reduce(0.0) { sum, item in
            guard let product = item.product else { return sum }
            return sum + (product.price * Double(item.quantity))
        }
        
        let combinedValue = cartTotal + matchedOrders.reduce(0.0) { sum, order in
            sum + order.subtotal
        }
        
        let isEligible = combinedValue >= configuration.freeDeliveryThreshold
        let estimatedSavings = isEligible ? configuration.standardDeliveryFee : 0.0
        
        return BatchOptimizationResult(
            combinedValue: combinedValue,
            isEligibleForFreeDelivery: isEligible,
            estimatedSavings: estimatedSavings,
            ordersInBatch: matchedOrders
        )
    }
}
