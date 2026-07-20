import Foundation

/// Static data fixtures for order transactions.
enum OrderFixtures {
    /// The complete list of exactly 20 deterministic orders (2 per user in our fixtures).
    static let all: [Order] = {
        let users = UserFixtures.all
        let products = ProductFixtures.all
        var orders: [Order] = []
        
        for i in 0..<20 {
            let indexString = String(format: "%02d", i + 1)
            let userIndex = i / 2
            let user = users[userIndex]
            
            // Pick a deterministic product from the catalog
            let product = products[i * 4 % products.count]
            let quantity = 1 + (i % 3)
            let subtotal = product.price * Double(quantity)
            
            let item = CartItem(
                id: UUID(uuidString: "50000000-0000-0000-0000-0000000000\(indexString)")!,
                product: product,
                quantity: quantity
            )
            
            let isPastOrder = i % 2 == 0
            
            let order = Order(
                id: "ORD-FIX-\(indexString)",
                user: user,
                items: [item],
                deliveryAddress: user.addresses[0],
                orderDate: Date(timeIntervalSinceNow: -3600.0 * Double(i)),
                deliveryDeadline: Date(timeIntervalSinceNow: 7200.0),
                deliveryOption: isPastOrder ? .instant(fee: 35.0) : .liveWave(waveID: "WAVE-FIX-01"),
                status: isPastOrder ? .delivered : .waveAssembling,
                subtotal: subtotal,
                deliveryFee: isPastOrder ? 35.0 : 0.0,
                totalAmount: isPastOrder ? (subtotal + 35.0) : subtotal
            )
            
            item.order = order
            orders.append(order)
        }
        
        return orders
    }()
}
