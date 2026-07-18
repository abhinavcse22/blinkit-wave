import Foundation

/// Represents the comprehensive, unified decision output of the Smart Wave Engine.
struct WaveRecommendation: Codable, Sendable, Hashable {
    /// The primary recommended checkout action.
    var primaryRecommendation: AIRecommendation
    
    /// List of alternative options available (e.g., standard instant dispatch).
    var alternativeRecommendations: [AIRecommendation]
    
    /// The optimization economics computed for the active neighborhood cluster.
    var batchResult: BatchOptimizationResult
    
    /// The next predicted wave slot forecast details.
    var predictedWaveSlot: WaveSlot
    
    /// The timing action evaluated to prevent SLA breaches.
    var deadlineAction: DeadlineAction
    
    /// Estimated delivery charge savings in Rupees.
    var estimatedSavings: Double
    
    /// Billed delivery charges in Rupees for the primary recommendation.
    var estimatedDeliveryFee: Double
    
    /// Estimated timestamp for order delivery.
    var estimatedETA: Date
    
    /// Confidence level of the AI prediction.
    var confidence: PredictionConfidence
    
    /// Wave type corresponding to the primary selection (live vs scheduled).
    var waveType: WaveType
    
    /// Current assembly or delivery state of the wave batch.
    var waveStatus: WaveStatus
    
    /// Flag indicating whether the primary recommendation qualifies for free delivery.
    var isFreeDelivery: Bool
    
    /// User-facing description explaining the recommendation logic.
    var explanation: String
}
