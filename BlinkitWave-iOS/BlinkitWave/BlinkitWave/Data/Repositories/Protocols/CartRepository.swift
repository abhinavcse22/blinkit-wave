import Foundation

/// Repository protocol defining session operations for the customer cart.
protocol CartRepository: Sendable {
    /// Retrieves the current active cart.
    func fetchCart() async throws -> Cart
    
    /// Adds a product to the cart with a specific quantity.
    func addItem(product: Product, quantity: Int) async throws -> Cart
    
    /// Removes a product from the cart by its SKU.
    func removeItem(productID: String) async throws -> Cart
    
    /// Clears all items in the cart.
    func clearCart() async throws -> Cart
}
