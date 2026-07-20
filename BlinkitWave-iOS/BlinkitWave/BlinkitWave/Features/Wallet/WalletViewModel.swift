import Foundation
import Observation

/// ViewModel managing Smart Wallet transactions and balances.
@Observable
final class WalletViewModel {
    // MARK: - State
    
    var wallet: Wallet?
    var totalSavings: Double = 0.0
    var wavesJoinedCount: Int = 0
    var isLoading = false
    var isDepositing = false
    
    // Auto-topup config settings
    var isAutoTopupEnabled = true
    var autoTopupThreshold = 150.0

    // MARK: - Dependencies
    
    private let walletRepository = AppContainer.shared.walletRepository
    private let userRepository = AppContainer.shared.userRepository

    init() {}

    // MARK: - Actions
    
    /// Loads the wallet data, profile savings metrics, and transaction logs.
    func loadWalletData() async {
        isLoading = true
        do {
            let activeWallet = try await walletRepository.fetchWallet()
            self.wallet = activeWallet
            
            let user = try await userRepository.fetchCurrentUser()
            if let savings = user.savings {
                self.totalSavings = savings.totalSavingsAmount
                self.wavesJoinedCount = savings.wavesJoinedCount
            }
        } catch {
            print("Failed to load wallet data: \(error)")
        }
        isLoading = false
    }

    /// Deposits top-up credit into the Smart Wallet.
    func deposit(amount: Double) async {
        isDepositing = true
        do {
            let updatedWallet = try await walletRepository.depositFunds(amount: amount, description: "Smart Deposit Topup")
            self.wallet = updatedWallet
        } catch {
            print("Failed to deposit funds: \(error)")
        }
        isDepositing = false
    }
}
