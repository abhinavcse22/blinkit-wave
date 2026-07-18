import Foundation
import SwiftData

/// Represents a purchasable grocery item in the application catalog.
@Model
final class Product: Codable, Identifiable {
    /// Unique catalog identifier (e.g. SKU).
    @Attribute(.unique) var id: String
    
    /// Display name of the product.
    var name: String
    
    /// Detailed description of the product.
    var productDescription: String
    
    /// Retail price in Rupees.
    var price: Double
    
    /// Image asset URL or file path.
    var imageURLString: String?
    
    /// Measurement details (e.g., "500 ml", "1 kg").
    var unitDescription: String
    
    /// Classification category this item is cataloged under.
    var category: Category?
    
    /// Flag indicating stock availability.
    var isStockAvailable: Bool

    init(
        id: String,
        name: String,
        productDescription: String,
        price: Double,
        imageURLString: String? = nil,
        unitDescription: String,
        category: Category? = nil,
        isStockAvailable: Bool = true
    ) {
        self.id = id
        self.name = name
        self.productDescription = productDescription
        self.price = price
        self.imageURLString = imageURLString
        self.unitDescription = unitDescription
        self.category = category
        self.isStockAvailable = isStockAvailable
    }

    // MARK: - Codable Conformance

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case productDescription
        case price
        case imageURLString
        case unitDescription
        case category
        case isStockAvailable
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.productDescription = try container.decode(String.self, forKey: .productDescription)
        self.price = try container.decode(Double.self, forKey: .price)
        self.imageURLString = try container.decodeIfPresent(String.self, forKey: .imageURLString)
        self.unitDescription = try container.decode(String.self, forKey: .unitDescription)
        self.category = try container.decodeIfPresent(Category.self, forKey: .category)
        self.isStockAvailable = try container.decode(Bool.self, forKey: .isStockAvailable)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(productDescription, forKey: .productDescription)
        try container.encode(price, forKey: .price)
        try container.encode(imageURLString, forKey: .imageURLString)
        try container.encode(unitDescription, forKey: .unitDescription)
        try container.encode(category, forKey: .category)
        try container.encode(isStockAvailable, forKey: .isStockAvailable)
    }
}
