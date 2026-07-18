import Foundation

/// Represents the level of confidence of AI-predicted slots based on historical patterns.
enum PredictionConfidence: String, Codable, Sendable, Hashable {
    /// Low probability of slot threshold match (surge or platform fees might apply).
    case low
    
    /// Medium probability of slot threshold match (high chance of free delivery).
    case medium
    
    /// High probability of slot threshold match (guaranteed matching and free delivery).
    case high
}
