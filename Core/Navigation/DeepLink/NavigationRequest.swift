import Foundation

/// A navigation command from any entry point in the app ecosystem.
///
/// External surfaces (Siri App Intents, Live Activities, Widgets, Push Notifications)
/// produce a `NavigationRequest` that the coordinator resolves into concrete navigation.
enum NavigationRequest: Sendable {

    case destination(AppDestination)
    case url(URL)
    case notification(userInfo: [String: String])
    case externalIntent(ExternalNavigationIntent, parameters: [String: String] = [:])
}

/// Known navigation intents from Siri, widgets, and system integrations.
enum ExternalNavigationIntent: String, Codable, Sendable, CaseIterable {

    case openHome
    case openCart
    case openProduct
    case openWaveRecommendation
    case openScheduledWave
    case openTracking
    case openWallet
    case openSavings
    case openSettings
}
