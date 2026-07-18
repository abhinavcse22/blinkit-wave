import Foundation
import SwiftData

/// Represents an individual debit or credit transaction inside a customer's Smart Wallet.
@Model
final class WalletTransaction: Codable, Identifiable {
    /// Unique transaction identifier.
    @Attribute(.unique) var id: UUID
    
    /// Wallet profile this transaction belongs to.
    var wallet: Wallet?
    
    /// Billed transactional amount (positive for deposits/topups, negative for checkout payments).
    var amount: Double
    
    /// The exact timestamp of the transaction.
    var date: Date
    
    /// Details about the transaction description.
    var transactionDescription: String

    init(
        id: UUID = UUID(),
        amount: Double,
        date: Date = Date(),
        transactionDescription: String
    ) {
        self.id = id
        self.amount = amount
        self.date = date
        self.transactionDescription = transactionDescription
    }

    // MARK: - Codable Conformance

    enum CodingKeys: String, CodingKey {
        case id
        case amount
        case date
        case transactionDescription
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.amount = try container.decode(Double.self, forKey: .amount)
        self.date = try container.decode(Date.self, forKey: .date)
        self.transactionDescription = try container.decode(String.self, forKey: .transactionDescription)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(amount, forKey: .amount)
        try container.encode(date, forKey: .date)
        try container.encode(transactionDescription, forKey: .transactionDescription)
    }
}
