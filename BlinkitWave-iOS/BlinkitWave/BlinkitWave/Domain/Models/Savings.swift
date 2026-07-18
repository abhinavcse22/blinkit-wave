import Foundation
import SwiftData

/// Tracks the cash savings achieved by a customer through wave optimizations.
@Model
final class Savings: Codable, Identifiable {
    /// Unique identifier for the savings record.
    @Attribute(.unique) var id: UUID
    
    /// User profile associated with the savings metric.
    var user: User?
    
    /// Aggregated delivery fee cost saved in Rupees.
    var totalSavingsAmount: Double
    
    /// Total count of successful delivery waves joined by the user.
    var wavesJoinedCount: Int
    
    /// Exact timestamp when savings was last updated.
    var lastSavedDate: Date

    init(
        id: UUID = UUID(),
        totalSavingsAmount: Double = 0.0,
        wavesJoinedCount: Int = 0,
        lastSavedDate: Date = Date()
    ) {
        self.id = id
        self.totalSavingsAmount = totalSavingsAmount
        self.wavesJoinedCount = wavesJoinedCount
        self.lastSavedDate = lastSavedDate
    }

    // MARK: - Codable Conformance

    enum CodingKeys: String, CodingKey {
        case id
        case totalSavingsAmount
        case wavesJoinedCount
        case lastSavedDate
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.totalSavingsAmount = try container.decode(Double.self, forKey: .totalSavingsAmount)
        self.wavesJoinedCount = try container.decode(Int.self, forKey: .wavesJoinedCount)
        self.lastSavedDate = try container.decode(Date.self, forKey: .lastSavedDate)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(totalSavingsAmount, forKey: .totalSavingsAmount)
        try container.encode(wavesJoinedCount, forKey: .wavesJoinedCount)
        try container.encode(lastSavedDate, forKey: .lastSavedDate)
    }
}
