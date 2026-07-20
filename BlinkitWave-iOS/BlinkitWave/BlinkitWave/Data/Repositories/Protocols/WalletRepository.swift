import Foundation

/// Repository protocol defining data access and operations for the customer Smart Wallet.
protocol WalletRepository: Sendable {
    /// Retrieves the current wallet balance and transaction logs.
    func fetchWallet() async throws -> Wallet
    
    /// Credits deposit funds into the wallet.
    func depositFunds(amount: Double, description: String) async throws -> Wallet
    
    /// Debits funds from the wallet for order checkout payments.
    func debitFunds(amount: Double, description: String) async throws -> Wallet
}
