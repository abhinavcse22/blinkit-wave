import Foundation
import SwiftData

/// Represents the customer account details, active settings, and associated history.
@Model
final class User: Codable, Identifiable {
    /// Unique user identifier.
    @Attribute(.unique) var id: UUID
    
    /// User's full name.
    var name: String
    
    /// User's email address.
    var email: String
    
    /// User's primary contact phone number.
    var phoneNumber: String
    
    /// Array of saved delivery addresses.
    var addresses: [Address] = []
    
    /// The user's active Smart Wallet profile.
    @Relationship(deleteRule: .cascade)
    var wallet: Wallet?
    
    /// History of checkout orders placed by this user.
    @Relationship(deleteRule: .cascade, inverse: \Order.user)
    var orders: [Order] = []
    
    /// Total aggregated delivery charge savings tracker.
    @Relationship(deleteRule: .cascade)
    var savings: Savings?

    init(
        id: UUID = UUID(),
        name: String,
        email: String,
        phoneNumber: String,
        addresses: [Address] = [],
        wallet: Wallet? = nil,
        orders: [Order] = [],
        savings: Savings? = nil
    ) {
        self.id = id
        self.name = name
        self.email = email
        self.phoneNumber = phoneNumber
        self.addresses = addresses
        self.wallet = wallet
        self.orders = orders
        self.savings = savings
    }

    // MARK: - Codable Conformance

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case phoneNumber
        case addresses
        case wallet
        case orders
        case savings
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.email = try container.decode(String.self, forKey: .email)
        self.phoneNumber = try container.decode(String.self, forKey: .phoneNumber)
        self.addresses = try container.decode([Address].self, forKey: .addresses)
        self.wallet = try container.decodeIfPresent(Wallet.self, forKey: .wallet)
        self.orders = try container.decodeIfPresent([Order].self, forKey: .orders) ?? []
        self.savings = try container.decodeIfPresent(Savings.self, forKey: .savings)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(email, forKey: .email)
        try container.encode(phoneNumber, forKey: .phoneNumber)
        try container.encode(addresses, forKey: .addresses)
        try container.encode(wallet, forKey: .wallet)
        try container.encode(orders, forKey: .orders)
        try container.encode(savings, forKey: .savings)
    }
}
