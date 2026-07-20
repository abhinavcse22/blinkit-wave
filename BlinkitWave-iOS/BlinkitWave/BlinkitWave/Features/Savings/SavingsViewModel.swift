import Foundation
import Observation

/// ViewModel for Savings metric analysis, calculating rider trip reductions.
@Observable
final class SavingsViewModel {
    // MARK: - State
    
    var totalSavings: Double = 0.0
    var wavesJoinedCount: Int = 0
    var tripsSaved = 0
    var carbonReducedKg = 0.0
    var isLoading = false

    // MARK: - Dependencies
    
    private let userRepository = AppContainer.shared.userRepository

    init() {}

    // MARK: - Actions
    
    /// Loads user savings metrics and computes environmental footprint conversions.
    func loadSavings() async {
        isLoading = true
        do {
            let user = try await userRepository.fetchCurrentUser()
            if let savings = user.savings {
                self.totalSavings = savings.totalSavingsAmount
                self.wavesJoinedCount = savings.wavesJoinedCount
                
                // Mocks: Environmental calculations
                self.tripsSaved = savings.wavesJoinedCount
                self.carbonReducedKg = Double(savings.wavesJoinedCount) * 0.42 // 420g carbon reduced per shared wave trip
            }
        } catch {
            print("Failed to load savings data: \(error)")
        }
        isLoading = false
    }
}
