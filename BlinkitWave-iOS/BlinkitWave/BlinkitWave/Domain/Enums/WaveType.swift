import Foundation

/// Defines the category of delivery waves in the system.
enum WaveType: String, Codable, Sendable, Hashable {
    /// A live delivery wave aggregating checkout orders currently coming from the neighborhood.
    case live
    
    /// A scheduled wave corresponding to predicted delivery slots with pre-allocated riders.
    case scheduled
}
