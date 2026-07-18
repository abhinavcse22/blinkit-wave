import Foundation
import SwiftData

/// Represents the customer's Smart Wallet, allowing deposits to unlock delivery waivers.
@Model
final class Wallet: Codable, Identifiable {
    /// Unique identifier for the wallet profile.
    @Attribute(.unique) var id: UUID
    
    /// User profile this wallet belongs to.
    var user: User?
    
    /// The current available deposit credit in Rupees.
    var balance: Double
    
    /// List of transaction records associated with this wallet.
    @Relationship(deleteRule: .cascade, inverse: \WalletTransaction.wallet)
    var transactions: [WalletTransaction] = []

    init(id: UUID = UUID(), balance: Double = 0.0, transactions: [WalletTransaction] = []) {
        self.id = id
        self.balance = balance
        self.transactions = transactions
    }

    // MARK: - Codable Conformance

    enum CodingKeys: String, CodingKey {
        case id
        case balance
        case transactions
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.balance = try container.decode(Double.self, forKey: .balance)
        self.transactions = try container.decode([WalletTransaction].self, forKey: .transactions)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(balance, forKey: .balance)
        try container.encode(transactions, forKey: .transactions)
    }
}
