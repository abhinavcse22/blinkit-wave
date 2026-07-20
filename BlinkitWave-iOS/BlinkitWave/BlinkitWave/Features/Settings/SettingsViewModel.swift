import Foundation
import Observation

/// ViewModel for Settings and developer options.
@Observable
final class SettingsViewModel {
    // MARK: - State
    
    var searchRadiusMeters = 500.0
    var defaultDeadlineMinutes = 120 // 2 hours
    var autoJoinWaves = true
    var enableSmartNotifications = true

    // MARK: - Dependencies
    
    private let userRepository = AppContainer.shared.userRepository

    init() {}

    // MARK: - Actions
    
    /// Loads settings config attributes.
    func loadSettings() async {
        // Can configure based on user profile preferences
    }
}
