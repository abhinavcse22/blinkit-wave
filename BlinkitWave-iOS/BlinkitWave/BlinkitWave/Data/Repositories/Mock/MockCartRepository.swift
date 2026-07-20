import Foundation

/// Concrete Mock implementation of CartRepository using a thread-safe unchecked Sendable class.
final class MockCartRepository: CartRepository, @unchecked Sendable {
    private var cart = Cart()

    func fetchCart() async throws -> Cart {
        cart
    }

    func addItem(product: Product, quantity: Int) async throws -> Cart {
        if let existing = cart.items.first(where: { $0.product?.id == product.id }) {
            existing.quantity += quantity
        } else {
            let newItem = CartItem(product: product, quantity: quantity)
            cart.items.append(newItem)
        }
        return cart
    }

    func removeItem(productID: String) async throws -> Cart {
        cart.items.removeAll { $0.product?.id == productID }
        return cart
    }

    func clearCart() async throws -> Cart {
        cart.items = []
        return cart
    }
}
