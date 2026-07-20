import Foundation

/// Central dependency container managing dependency injection wiring for the application.
/// Exposes strictly repository protocols to ensure concrete implementations can be swapped without UI changes.
final class AppContainer: Sendable {
    /// Shared singleton container instance.
    static let shared = AppContainer()
    
    // MARK: - Repositories (Exposed only via protocols)
    
    /// Repository contract managing product catalog lookups.
    let productRepository: any ProductRepository
    
    /// Repository contract managing category index lookups.
    let categoryRepository: any CategoryRepository
    
    /// Repository contract managing the user's active shopping cart session.
    let cartRepository: any CartRepository
    
    /// Repository contract managing placed order histories.
    let orderRepository: any OrderRepository
    
    /// Repository contract managing customer profiles and address clusters.
    let userRepository: any UserRepository
    
    /// Repository contract managing smart wallet balances and transaction logs.
    let walletRepository: any WalletRepository
    
    /// Repository contract managing neighborhood wave groups.
    let waveRepository: any WaveRepository
    
    // MARK: - Services (Stateless mock engines)
    
    /// Service managing stock validation.
    let inventoryService: MockInventoryService
    
    /// Service managing distance calculation.
    let locationService: MockLocationService
    
    /// Service managing wave assembly status updates.
    let waveService: MockWaveService

    private init() {
        self.productRepository = MockProductRepository()
        self.categoryRepository = MockCategoryRepository()
        self.cartRepository = MockCartRepository()
        self.orderRepository = MockOrderRepository()
        self.userRepository = MockUserRepository()
        self.walletRepository = MockWalletRepository()
        self.waveRepository = MockWaveRepository()
        
        self.inventoryService = MockInventoryService()
        self.locationService = MockLocationService()
        self.waveService = MockWaveService()
    }
}
