#if canImport(ActivityKit)
import ActivityKit
import Foundation

/// Activity Attributes defining the Dynamic Island and Lock Screen tracking states.
struct WaveActivityAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        /// Time remaining until dispatch or delivery.
        var minutesRemaining: Int
        
        /// Label of the current tracking step (e.g. "Driver Assigned").
        var currentStepDescription: String
        
        /// Estimated savings amount.
        var accumulatedSavings: Double
    }
    
    /// Target order identifier.
    var orderID: String
}
#endif
