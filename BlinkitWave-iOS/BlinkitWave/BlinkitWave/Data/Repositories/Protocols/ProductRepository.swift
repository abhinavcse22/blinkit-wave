import Foundation

/// Repository protocol defining data access for catalog products.
protocol ProductRepository: Sendable {
    /// Retrieves all products available in the catalog.
    func fetchProducts() async throws -> [Product]
    
    /// Retrieves a single product by its unique SKU identifier.
    func fetchProduct(byID id: String) async throws -> Product?
    
    /// Retrieves products belonging to a specific category.
    func fetchProducts(inCategory categoryID: String) async throws -> [Product]
}
