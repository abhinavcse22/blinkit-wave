import Foundation
import Observation

/// ViewModel for the Home Experience, coordinating catalog data for the familiar
/// Blinkit shopping screen. Smart Wave has no presence here — it only exists
/// during Checkout, once a real cart exists.
@Observable
final class HomeViewModel {
    // MARK: - State

    var greeting: String = "Hello!"
    var currentUser: User?
    var categories: [Category] = []
    var recommendedProducts: [Product] = []
    var trendingProducts: [Product] = []
    var walletBalance: Double = 0.0
    var totalSavings: Double = 0.0

    // MARK: - Dependencies

    private let productRepository = AppContainer.shared.productRepository
    private let categoryRepository = AppContainer.shared.categoryRepository
    private let userRepository = AppContainer.shared.userRepository
    private let walletRepository = AppContainer.shared.walletRepository

    init() {}

    // MARK: - Actions

    /// Loads all initial data for the Home view.
    func loadData() async {
        do {
            let user = try await userRepository.fetchCurrentUser()
            self.currentUser = user
            self.greeting = getGreeting(for: user.name)
            self.totalSavings = user.savings?.totalSavingsAmount ?? 0.0

            self.categories = try await categoryRepository.fetchCategories()

            let allProducts = try await productRepository.fetchProducts()
            self.recommendedProducts = Array(allProducts.prefix(6))
            self.trendingProducts = Array(allProducts.suffix(6))

            let wallet = try await walletRepository.fetchWallet()
            self.walletBalance = wallet.balance
        } catch {
            print("Failed to load Home experience data: \(error)")
        }
    }

    // MARK: - Helpers

    private func getGreeting(for name: String) -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        let prefix: String
        if hour < 12 {
            prefix = "Good Morning"
        } else if hour < 17 {
            prefix = "Good Afternoon"
        } else {
            prefix = "Good Evening"
        }
        return "\(prefix), \(name.split(separator: " ").first ?? "there")!"
    }
}
