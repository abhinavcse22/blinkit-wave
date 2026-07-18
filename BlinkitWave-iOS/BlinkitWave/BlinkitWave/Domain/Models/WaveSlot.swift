import Foundation
import SwiftData

/// Represents an AI-predicted high-density delivery slot for demand forecast optimization.
@Model
final class WaveSlot: Codable, Identifiable {
    /// Unique identifier for the slot (e.g. "SLOT-12345").
    @Attribute(.unique) var id: String
    
    /// The scheduled beginning time of the delivery slot window.
    var startTime: Date
    
    /// The scheduled closing time of the delivery slot window.
    var endTime: Date
    
    /// Expected count of neighbor orders predicted during this window.
    var predictedOrderCount: Int
    
    /// Probability confidence score computed by the predictive models.
    var predictedConfidence: PredictionConfidence
    
    /// Estimated delivery charge discount (e.g. 35.0 Rupees off for free delivery).
    var estimatedDeliveryDiscount: Double

    init(
        id: String,
        startTime: Date,
        endTime: Date,
        predictedOrderCount: Int,
        predictedConfidence: PredictionConfidence,
        estimatedDeliveryDiscount: Double
    ) {
        self.id = id
        self.startTime = startTime
        self.endTime = endTime
        self.predictedOrderCount = predictedOrderCount
        self.predictedConfidence = predictedConfidence
        self.estimatedDeliveryDiscount = estimatedDeliveryDiscount
    }

    // MARK: - Codable Conformance

    enum CodingKeys: String, CodingKey {
        case id
        case startTime
        case endTime
        case predictedOrderCount
        case predictedConfidence
        case estimatedDeliveryDiscount
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.startTime = try container.decode(Date.self, forKey: .startTime)
        self.endTime = try container.decode(Date.self, forKey: .endTime)
        self.predictedOrderCount = try container.decode(Int.self, forKey: .predictedOrderCount)
        self.predictedConfidence = try container.decode(PredictionConfidence.self, forKey: .predictedConfidence)
        self.estimatedDeliveryDiscount = try container.decode(Double.self, forKey: .estimatedDeliveryDiscount)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(startTime, forKey: .startTime)
        try container.encode(endTime, forKey: .endTime)
        try container.encode(predictedOrderCount, forKey: .predictedOrderCount)
        try container.encode(predictedConfidence, forKey: .predictedConfidence)
        try container.encode(estimatedDeliveryDiscount, forKey: .estimatedDeliveryDiscount)
    }
}
