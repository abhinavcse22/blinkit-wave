import Foundation

/// Represents the status in the lifecycle of a batch delivery Wave.
enum WaveStatus: String, Codable, Sendable, Hashable {
    /// The wave is actively accepting orders to satisfy target optimization requirements.
    case assembling
    
    /// The wave has met optimization criteria, and is closed to new orders.
    case confirmed
    
    /// The wave orders have been bundled and dispatched with a rider.
    case dispatched
    
    /// All orders in the wave have been delivered successfully.
    case completed
}
