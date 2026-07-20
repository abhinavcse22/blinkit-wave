import Foundation

/// Concrete Mock implementation of OrderRepository.
final class MockOrderRepository: OrderRepository, @unchecked Sendable {
    private var orders: [Order]

    init() {
        self.orders = OrderFixtures.all
    }

    func fetchOrders() async throws -> [Order] {
        orders
    }

    func fetchOrder(byID id: String) async throws -> Order? {
        orders.first { $0.id == id }
    }

    func placeOrder(_ order: Order) async throws -> Order {
        orders.append(order)
        return order
    }

    func updateOrderStatus(orderID: String, status: OrderStatus) async throws -> Order? {
        guard let index = orders.firstIndex(where: { $0.id == orderID }) else {
            throw RepositoryError.notFound(id: orderID)
        }
        orders[index].status = status
        return orders[index]
    }
}
