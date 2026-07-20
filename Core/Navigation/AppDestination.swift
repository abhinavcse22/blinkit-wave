import Foundation

/// Every navigable screen in Blinkit Wave.
///
/// Conforms to `Hashable` for `NavigationPath` and `Codable` for deep-link
/// persistence, widget state, and notification payload decoding.
enum AppDestination: Hashable, Codable, Sendable {

    case home
    case product(productID: String)
    case cart
    case waveRecommendation
    case scheduledWave(waveID: String?)
    case tracking(orderID: String)
    case wallet
    case savings
    case settings
}

// MARK: - Tab Association

extension AppDestination {

    /// The primary tab that owns this destination's root context.
    ///
    /// Smart Wave has no standalone tab — it only exists as a checkout step
    /// reached from an active cart, so both destinations live on the Cart tab's stack.
    var preferredTab: AppTab {
        switch self {
        case .home, .product:
            return .home
        case .cart, .waveRecommendation, .scheduledWave:
            return .cart
        case .tracking:
            return .home
        case .wallet, .savings:
            return .wallet
        case .settings:
            return .settings
        }
    }

    /// Whether this destination should be pushed onto the tab's navigation stack
    /// rather than treated as a tab root.
    var isStackDestination: Bool {
        switch self {
        case .home, .cart, .wallet, .settings:
            return false
        case .product, .waveRecommendation, .scheduledWave, .tracking, .savings:
            return true
        }
    }
}
