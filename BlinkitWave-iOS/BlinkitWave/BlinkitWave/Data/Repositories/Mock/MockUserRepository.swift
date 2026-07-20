import Foundation

/// Concrete Mock implementation of UserRepository.
final class MockUserRepository: UserRepository, @unchecked Sendable {
    private var users: [User]

    init() {
        self.users = UserFixtures.all
    }

    func fetchCurrentUser() async throws -> User {
        users[0]
    }

    func updateUserAddresses(_ addresses: [Address]) async throws -> User {
        let currentUser = users[0]
        currentUser.addresses = addresses
        return currentUser
    }

    func updateUserSavings(savingsAmount: Double) async throws -> User {
        let currentUser = users[0]
        guard let savings = currentUser.savings else {
            let newSavings = Savings(totalSavingsAmount: savingsAmount, wavesJoinedCount: 1, lastSavedDate: Date())
            currentUser.savings = newSavings
            return currentUser
        }
        savings.totalSavingsAmount += savingsAmount
        savings.wavesJoinedCount += 1
        savings.lastSavedDate = Date()
        return currentUser
    }
}
