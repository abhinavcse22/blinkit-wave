import Foundation

/// Repository protocol defining data access and operations for order transactions.
protocol OrderRepository: Sendable {
    /// Retrieves all orders placed by the user.
    func fetchOrders() async throws -> [Order]
    
    /// Retrieves a single order details by its ID.
    func fetchOrder(byID id: String) async throws -> Order?
    
    /// Places and registers a new order.
    func placeOrder(_ order: Order) async throws -> Order
    
    /// Updates the delivery tracking status of an existing order.
    func updateOrderStatus(orderID: String, status: OrderStatus) async throws -> Order?
}
