import Foundation
import SwiftData

/// Represents the user's active shopping cart.
@Model
final class Cart: Codable, Identifiable {
    /// Unique identifier for the cart.
    @Attribute(.unique) var id: UUID
    
    /// List of item records added to the cart.
    @Relationship(deleteRule: .cascade, inverse: \CartItem.cart)
    var items: [CartItem] = []
    
    /// The user who owns this cart.
    var user: User?

    /// Calculates the sum of all item prices in the cart.
    var subtotal: Double {
        items.reduce(0.0) { $0 + $1.totalPrice }
    }

    /// Verifies if the cart value reaches the free delivery threshold of ₹150.
    var isEligibleForFreeDelivery: Bool {
        subtotal >= 150.0
    }

    init(id: UUID = UUID(), items: [CartItem] = []) {
        self.id = id
        self.items = items
    }

    // MARK: - Codable Conformance

    enum CodingKeys: String, CodingKey {
        case id
        case items
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.items = try container.decode([CartItem].self, forKey: .items)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(items, forKey: .items)
    }
}
