import Foundation
import Observation

/// ViewModel for Wave Details, tracking assembly progress and neighborhood details.
@Observable
final class WaveDetailsViewModel {
    // MARK: - State
    
    var wave: Wave?
    var isLoading = false
    var participantsCount = 0
    var progressPercent = 0.0

    // MARK: - Dependencies
    
    private let waveRepository = AppContainer.shared.waveRepository

    init() {}

    // MARK: - Actions
    
    /// Loads a specific wave details by ID or fetches default live wave.
    func loadWave(byID id: String?) async {
        isLoading = true
        do {
            let targetID = id ?? "WAVE-FIX-01"
            let found = try await waveRepository.fetchWave(byID: targetID)
            self.wave = found
            
            // Set mock participant counts
            self.participantsCount = (found?.orders.count ?? 0) + 2
            
            // Calculate threshold subtotal progress
            let threshold = EngineConfiguration.defaultConfiguration.freeDeliveryThreshold
            let totalVal = found?.orders.reduce(0.0) { $0 + $1.subtotal } ?? 0.0
            self.progressPercent = min(1.0, totalVal / threshold)
        } catch {
            print("Failed to load wave detail: \(error)")
        }
        isLoading = false
    }
}
