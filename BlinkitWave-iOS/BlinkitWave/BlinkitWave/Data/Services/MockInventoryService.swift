import Foundation

/// Stateless mock service responsible for local stock verification and inventory checks.
struct MockInventoryService {
    /// Checks if a single product is currently in stock.
    func isProductAvailable(productID: String) -> Bool {
        let matched = ProductFixtures.all.first { $0.id == productID }
        return matched?.isStockAvailable ?? false
    }

    /// Verifies if all items in a cart list are ready in stock.
    func checkInventory(for items: [CartItem]) -> Bool {
        items.allSatisfy { item in
            guard let product = item.product else { return false }
            return isProductAvailable(productID: product.id)
        }
    }
}
