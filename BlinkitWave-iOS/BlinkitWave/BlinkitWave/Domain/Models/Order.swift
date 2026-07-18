import Foundation
import SwiftData

/// Represents a customer order transaction in the system.
@Model
final class Order: Codable, Identifiable {
    /// Unique identifier for the order (e.g. "ORD-12345").
    @Attribute(.unique) var id: String
    
    /// User profile this order is associated with.
    var user: User?
    
    /// Purchased product items inside the order.
    @Relationship(deleteRule: .cascade, inverse: \CartItem.order)
    var items: [CartItem] = []
    
    /// The physical address designated for shipping.
    var deliveryAddress: Address
    
    /// The exact timestamp when this order was placed.
    var orderDate: Date
    
    /// The deadline before which this order must be delivered.
    var deliveryDeadline: Date
    
    /// The selected delivery type option (Instant, Live Wave, Scheduled Wave, etc.).
    var deliveryOption: DeliveryOption
    
    /// Current tracking status of the order transaction.
    var status: OrderStatus
    
    /// The batch delivery Wave cluster this order is grouped into, if applicable.
    var wave: Wave?
    
    /// Sum of product items in the order.
    var subtotal: Double
    
    /// Applied delivery service charge.
    var deliveryFee: Double
    
    /// Discount applied from Smart Wallet funds.
    var walletDiscount: Double
    
    /// Final billed cost of the transaction (subtotal + fee - discount).
    var totalAmount: Double

    init(
        id: String,
        user: User? = nil,
        items: [CartItem] = [],
        deliveryAddress: Address,
        orderDate: Date = Date(),
        deliveryDeadline: Date,
        deliveryOption: DeliveryOption,
        status: OrderStatus = .placed,
        wave: Wave? = nil,
        subtotal: Double,
        deliveryFee: Double,
        walletDiscount: Double = 0.0,
        totalAmount: Double
    ) {
        self.id = id
        self.user = user
        self.items = items
        self.deliveryAddress = deliveryAddress
        self.orderDate = orderDate
        self.deliveryDeadline = deliveryDeadline
        self.deliveryOption = deliveryOption
        self.status = status
        self.wave = wave
        self.subtotal = subtotal
        self.deliveryFee = deliveryFee
        self.walletDiscount = walletDiscount
        self.totalAmount = totalAmount
    }

    // MARK: - Codable Conformance

    enum CodingKeys: String, CodingKey {
        case id
        case items
        case deliveryAddress
        case orderDate
        case deliveryDeadline
        case deliveryOption
        case status
        case subtotal
        case deliveryFee
        case walletDiscount
        case totalAmount
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.items = try container.decode([CartItem].self, forKey: .items)
        self.deliveryAddress = try container.decode(Address.self, forKey: .deliveryAddress)
        self.orderDate = try container.decode(Date.self, forKey: .orderDate)
        self.deliveryDeadline = try container.decode(Date.self, forKey: .deliveryDeadline)
        self.deliveryOption = try container.decode(DeliveryOption.self, forKey: .deliveryOption)
        self.status = try container.decode(OrderStatus.self, forKey: .status)
        self.subtotal = try container.decode(Double.self, forKey: .subtotal)
        self.deliveryFee = try container.decode(Double.self, forKey: .deliveryFee)
        self.walletDiscount = try container.decode(Double.self, forKey: .walletDiscount)
        self.totalAmount = try container.decode(Double.self, forKey: .totalAmount)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(items, forKey: .items)
        try container.encode(deliveryAddress, forKey: .deliveryAddress)
        try container.encode(orderDate, forKey: .orderDate)
        try container.encode(deliveryDeadline, forKey: .deliveryDeadline)
        try container.encode(deliveryOption, forKey: .deliveryOption)
        try container.encode(status, forKey: .status)
        try container.encode(subtotal, forKey: .subtotal)
        try container.encode(deliveryFee, forKey: .deliveryFee)
        try container.encode(walletDiscount, forKey: .walletDiscount)
        try container.encode(totalAmount, forKey: .totalAmount)
    }
}
