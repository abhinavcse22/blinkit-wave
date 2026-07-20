import Foundation

/// Concrete Mock implementation of CategoryRepository returning categories from fixtures.
final class MockCategoryRepository: CategoryRepository {
    private let categories: [Category] = CategoryFixtures.all

    func fetchCategories() async throws -> [Category] {
        categories
    }

    func fetchCategory(byID id: String) async throws -> Category? {
        categories.first { $0.id == id }
    }
}
