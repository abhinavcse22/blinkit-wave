import Foundation

/// Centralizes all configurable business rules and thresholds for the Smart Wave Engine.
struct EngineConfiguration: Codable, Sendable, Hashable {
    /// The order value threshold in Rupees to qualify for free delivery (e.g., ₹150.0).
    var freeDeliveryThreshold: Double
    
    /// The maximum radius in meters to cluster nearby neighborhood checkouts (e.g., 500.0 meters).
    var deliveryRadiusMeters: Double
    
    /// The maximum time in seconds to wait for a wave assembly (e.g., 1800.0 seconds / 30 minutes).
    var maxWaitTimeSeconds: Double
    
    /// The standard delivery fee charged for instant delivery (e.g., ₹35.0).
    var standardDeliveryFee: Double
    
    /// The safety buffer in seconds before delivery deadline to force dispatch (e.g., 900.0 seconds / 15 minutes).
    var dispatchBufferSeconds: Double

    /// The default configuration instance used across the system.
    static let defaultConfiguration = EngineConfiguration(
        freeDeliveryThreshold: 150.0,
        deliveryRadiusMeters: 500.0,
        maxWaitTimeSeconds: 1800.0,
        standardDeliveryFee: 35.0,
        dispatchBufferSeconds: 900.0
    )
}
