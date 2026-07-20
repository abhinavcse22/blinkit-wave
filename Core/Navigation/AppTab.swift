import Foundation

/// Primary tab sections for the app's root `TabView`.
enum AppTab: String, Hashable, Codable, CaseIterable, Sendable {

    case home
    case cart
    case wallet
    case settings

    /// Root destination rendered when a tab is selected with an empty stack.
    var rootDestination: AppDestination {
        switch self {
        case .home:
            return .home
        case .cart:
            return .cart
        case .wallet:
            return .wallet
        case .settings:
            return .settings
        }
    }
}
