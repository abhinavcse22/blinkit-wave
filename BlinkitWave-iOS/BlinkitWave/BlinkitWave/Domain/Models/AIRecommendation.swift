import Foundation

/// Models an optimization recommendation from the Smart Wave Engine for user cart checkouts.
struct AIRecommendation: Codable, Sendable, Hashable {
    /// Suggested delivery options parsed by the engine (e.g. joining an active wave or scheduling).
    var recommendedOption: DeliveryOption
    
    /// Estimated savings amount in Rupees by opting for the recommendation.
    var savingsAmount: Double
    
    /// Human readable message explaining the recommendation logic to the user.
    var explanationText: String
    
    /// Expiry timestamp for the recommendation validity.
    var expiresAt: Date

    init(
        recommendedOption: DeliveryOption,
        savingsAmount: Double,
        explanationText: String,
        expiresAt: Date
    ) {
        self.recommendedOption = recommendedOption
        self.savingsAmount = savingsAmount
        self.explanationText = explanationText
        self.expiresAt = expiresAt
    }
}
