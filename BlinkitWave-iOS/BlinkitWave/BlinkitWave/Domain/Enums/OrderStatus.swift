import Foundation

/// Represents the possible status states of an order in the Blinkit Wave system.
enum OrderStatus: String, Codable, Sendable, Hashable {
    /// The order has been placed by the user but not yet processed.
    case placed
    
    /// The order is actively waiting for nearby orders to assemble a Wave batch.
    case waveAssembling
    
    /// The wave has been formed and confirmed. Dispatch is imminent.
    case waveConfirmed
    
    /// The wave order has been dispatched with a rider.
    case dispatched
    
    /// The order has been successfully delivered to the user.
    case delivered
    
    /// The order has been cancelled.
    case cancelled
}
