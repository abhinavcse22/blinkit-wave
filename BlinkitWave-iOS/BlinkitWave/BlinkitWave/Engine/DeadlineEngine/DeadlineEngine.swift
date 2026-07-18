import Foundation

/// Defines the action path decided by the SLA constraint engine.
enum DeadlineAction: Codable, Sendable, Hashable {
    /// Safe to wait for a delivery wave to form.
    case wait(remainingSeconds: Double)
    
    /// Deadline is approaching, but matching threshold is satisfied. Dispatch immediately.
    case dispatchNow
    
    /// Deadline is approaching, threshold is not satisfied. Must dispatch instantly with fee.
    case fallbackToInstant
    
    /// Threshold not met, but user has time to deposit credit to meet the free delivery criteria.
    case suggestSmartWallet
}

/// Pure component responsible for time budget calculations to prevent order SLA violations.
struct DeadlineEngine {
    /// Injected business configurations.
    let configuration: EngineConfiguration

    /// Processes chronological inputs to decide dispatch urgency.
    /// - Parameters:
    ///   - currentTime: The reference time of checkout execution.
    ///   - deadline: The deadline delivery date chosen by the user.
    ///   - isThresholdMet: Flag specifying whether nearby matched baskets meet the free delivery total.
    /// - Returns: Suggested timing action.
    func evaluateDeadline(currentTime: Date, deadline: Date, isThresholdMet: Bool) -> DeadlineAction {
        let remainingSeconds = deadline.timeIntervalSince(currentTime)
        
        // SLA breach limit reached
        if remainingSeconds <= configuration.dispatchBufferSeconds {
            return isThresholdMet ? .dispatchNow : .fallbackToInstant
        }
        
        // Under 30 minutes left, but above dispatch buffer -> suggest Wallet to unlock wave checkout immediately
        if !isThresholdMet && remainingSeconds < (configuration.dispatchBufferSeconds + 900.0) {
            return .suggestSmartWallet
        }
        
        // Sufficient time budget remaining -> wait for order cluster accumulation
        return .wait(remainingSeconds: remainingSeconds)
    }
}
