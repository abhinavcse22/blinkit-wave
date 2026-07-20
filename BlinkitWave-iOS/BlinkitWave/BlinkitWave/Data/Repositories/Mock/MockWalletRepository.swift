import Foundation

/// Concrete Mock implementation of WalletRepository.
final class MockWalletRepository: WalletRepository, @unchecked Sendable {
    private var wallet: Wallet

    init() {
        self.wallet = UserFixtures.defaultUser.wallet ?? Wallet(balance: 0.0)
    }

    func fetchWallet() async throws -> Wallet {
        wallet
    }

    func depositFunds(amount: Double, description: String) async throws -> Wallet {
        wallet.balance += amount
        let transaction = WalletTransaction(
            amount: amount,
            date: Date(),
            transactionDescription: description
        )
        wallet.transactions.append(transaction)
        return wallet
    }

    func debitFunds(amount: Double, description: String) async throws -> Wallet {
        guard wallet.balance >= amount else {
            throw RepositoryError.invalidState(reason: "Insufficient wallet balance.")
        }
        wallet.balance -= amount
        let transaction = WalletTransaction(
            amount: -amount,
            date: Date(),
            transactionDescription: description
        )
        wallet.transactions.append(transaction)
        return wallet
    }
}
