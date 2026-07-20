import Foundation

/// Repository protocol defining data access for catalog categories.
protocol CategoryRepository: Sendable {
    /// Retrieves all categories in the system.
    func fetchCategories() async throws -> [Category]
    
    /// Retrieves a single category by its unique code identifier.
    func fetchCategory(byID id: String) async throws -> Category?
}
