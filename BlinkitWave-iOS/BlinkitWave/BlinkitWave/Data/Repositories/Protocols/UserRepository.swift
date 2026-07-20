import Foundation

/// Repository protocol defining data access for user accounts and profile parameters.
protocol UserRepository: Sendable {
    /// Retrieves the current authenticated user profile.
    func fetchCurrentUser() async throws -> User
    
    /// Updates the user's saved shipping addresses.
    func updateUserAddresses(_ addresses: [Address]) async throws -> User
    
    /// Increments user savings metrics based on matching waves.
    func updateUserSavings(savingsAmount: Double) async throws -> User
}
