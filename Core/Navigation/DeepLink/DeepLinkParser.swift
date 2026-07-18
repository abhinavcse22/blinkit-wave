import Foundation

/// Parses URLs and notification payloads into `AppDestination` values.
///
/// URL scheme: `blinkitwave://<host>/<pathComponents>`
///
/// Examples:
/// - `blinkitwave://product/SKU-123`
/// - `blinkitwave://tracking/ORD-456`
/// - `blinkitwave://cart`
enum DeepLinkParser {

    static let scheme = "blinkitwave"

    // MARK: - URL Parsing

    static func destination(from url: URL) -> AppDestination? {
        guard url.scheme?.lowercased() == scheme else { return nil }

        let host = url.host?.lowercased() ?? ""
        let pathComponents = url.pathComponents.filter { $0 != "/" }

        switch host {
        case "home":
            return .home
        case "product":
            guard let id = pathComponents.first else { return nil }
            return .product(productID: id)
        case "cart":
            return .cart
        case "wave", "wave-recommendation":
            return .waveRecommendation
        case "scheduled-wave":
            return .scheduledWave(waveID: pathComponents.first)
        case "tracking":
            guard let id = pathComponents.first else { return nil }
            return .tracking(orderID: id)
        case "wallet":
            return .wallet
        case "savings":
            return .savings
        case "settings":
            return .settings
        default:
            return nil
        }
    }

    // MARK: - Notification Parsing

    static func destination(fromNotification userInfo: [String: String]) -> AppDestination? {
        guard let route = userInfo["route"]?.lowercased() else { return nil }

        switch route {
        case "home":
            return .home
        case "product":
            guard let id = userInfo["product_id"] else { return nil }
            return .product(productID: id)
        case "cart":
            return .cart
        case "wave", "wave_recommendation":
            return .waveRecommendation
        case "scheduled_wave":
            return .scheduledWave(waveID: userInfo["wave_id"])
        case "tracking":
            guard let id = userInfo["order_id"] else { return nil }
            return .tracking(orderID: id)
        case "wallet":
            return .wallet
        case "savings":
            return .savings
        case "settings":
            return .settings
        default:
            return nil
        }
    }

    // MARK: - External Intent Parsing

    static func destination(
        from intent: ExternalNavigationIntent,
        parameters: [String: String] = [:]
    ) -> AppDestination {
        switch intent {
        case .openHome:
            return .home
        case .openCart:
            return .cart
        case .openProduct:
            return .product(productID: parameters["product_id"] ?? "")
        case .openWaveRecommendation:
            return .waveRecommendation
        case .openScheduledWave:
            return .scheduledWave(waveID: parameters["wave_id"])
        case .openTracking:
            return .tracking(orderID: parameters["order_id"] ?? "")
        case .openWallet:
            return .wallet
        case .openSavings:
            return .savings
        case .openSettings:
            return .settings
        }
    }

    // MARK: - URL Generation

    static func url(for destination: AppDestination) -> URL? {
        var components = URLComponents()
        components.scheme = scheme

        switch destination {
        case .home:
            components.host = "home"
        case .product(let productID):
            components.host = "product"
            components.path = "/\(productID)"
        case .cart:
            components.host = "cart"
        case .waveRecommendation:
            components.host = "wave"
        case .scheduledWave(let waveID):
            components.host = "scheduled-wave"
            if let waveID {
                components.path = "/\(waveID)"
            }
        case .tracking(let orderID):
            components.host = "tracking"
            components.path = "/\(orderID)"
        case .wallet:
            components.host = "wallet"
        case .savings:
            components.host = "savings"
        case .settings:
            components.host = "settings"
        }

        return components.url
    }
}
