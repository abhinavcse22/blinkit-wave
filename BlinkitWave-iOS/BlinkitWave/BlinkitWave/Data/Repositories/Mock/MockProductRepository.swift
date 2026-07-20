import Foundation

/// Concrete Mock implementation of ProductRepository returning data from fixtures.
final class MockProductRepository: ProductRepository {
    private let products: [Product] = ProductFixtures.all

    func fetchProducts() async throws -> [Product] {
        products
    }

    func fetchProduct(byID id: String) async throws -> Product? {
        products.first { $0.id == id }
    }

    func fetchProducts(inCategory categoryID: String) async throws -> [Product] {
        products.filter { $0.category?.id == categoryID }
    }
}
