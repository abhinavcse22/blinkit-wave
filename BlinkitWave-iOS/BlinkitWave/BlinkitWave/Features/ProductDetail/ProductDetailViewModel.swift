import Foundation
import Observation

/// ViewModel handling the Product Details state and cart additions.
@Observable
final class ProductDetailViewModel {
    // MARK: - State
    
    var product: Product?
    var isLoading = false
    var quantity = 1
    var isAdded = false

    // MARK: - Dependencies
    
    private let productRepository = AppContainer.shared.productRepository
    private let cartRepository = AppContainer.shared.cartRepository

    init() {}

    // MARK: - Actions
    
    /// Loads a specific product from the repository.
    func loadProduct(byID id: String) async {
        isLoading = true
        do {
            self.product = try await productRepository.fetchProduct(byID: id)
        } catch {
            print("Failed to load product detail: \(error)")
        }
        isLoading = false
    }

    /// Adds the current product to the cart with the selected quantity.
    func addToCart() async {
        guard let product = product else { return }
        do {
            _ = try await cartRepository.addItem(product: product, quantity: quantity)
            isAdded = true
            try? await Task.sleep(for: .seconds(1.5))
            isAdded = false
        } catch {
            print("Failed to add product to cart: \(error)")
        }
    }
}
