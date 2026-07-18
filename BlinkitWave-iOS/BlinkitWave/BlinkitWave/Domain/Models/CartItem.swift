import Foundation
import SwiftData

/// Represents an item selected in a shopping cart or checkout order.
@Model
final class CartItem: Codable, Identifiable {
    /// Unique identifier for the cart item.
    @Attribute(.unique) var id: UUID
    
    /// The associated product item.
    var product: Product?
    
    /// Selected item quantity.
    var quantity: Int
    
    /// The shopping cart this item belongs to.
    var cart: Cart?
    
    /// The order this item belongs to.
    var order: Order?

    /// Calculates the total price of this item based on quantity.
    var totalPrice: Double {
        guard let price = product?.price else { return 0.0 }
        return price * Double(quantity)
    }

    init(id: UUID = UUID(), product: Product, quantity: Int) {
        self.id = id
        self.product = product
        self.quantity = quantity
    }

    // MARK: - Codable Conformance

    enum CodingKeys: String, CodingKey {
        case id
        case product
        case quantity
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.product = try container.decodeIfPresent(Product.self, forKey: .product)
        self.quantity = try container.decode(Int.self, forKey: .quantity)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(product, forKey: .product)
        try container.encode(quantity, forKey: .quantity)
    }
}
