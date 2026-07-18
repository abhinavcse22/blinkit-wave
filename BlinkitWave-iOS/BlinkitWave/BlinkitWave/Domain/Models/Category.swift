import Foundation
import SwiftData

/// Represents a classification category for products in the catalog.
@Model
final class Category: Codable, Identifiable {
    /// Unique identifier for the category (e.g. "dairy", "fruits").
    @Attribute(.unique) var id: String
    
    /// Display name of the category.
    var name: String
    
    /// SF Symbol icon name representing the category.
    var iconName: String
    
    /// Set of products grouped under this category.
    @Relationship(deleteRule: .nullify, inverse: \Product.category)
    var products: [Product] = []

    init(id: String, name: String, iconName: String, products: [Product] = []) {
        self.id = id
        self.name = name
        self.iconName = iconName
        self.products = products
    }

    // MARK: - Codable Conformance

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case iconName
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.iconName = try container.decode(String.self, forKey: .iconName)
        self.products = []
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(iconName, forKey: .iconName)
    }
}
