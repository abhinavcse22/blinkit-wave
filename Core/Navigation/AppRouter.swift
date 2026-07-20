import SwiftUI

/// Maps `AppDestination` values to views.
///
/// Replace placeholder views with real feature modules as they are built.
/// The routing table stays centralized so navigation paths never change.
struct AppRouter {

    @ViewBuilder
    static func view(for destination: AppDestination) -> some View {
        switch destination {
        case .home:
            HomeView()
        case .product(let productID):
            ProductDetailView(productID: productID)
        case .cart:
            CartView()
        case .waveRecommendation:
            WaveRecommendationView()
        case .scheduledWave(let waveID):
            WaveDetailsView(waveID: waveID)
        case .tracking(let orderID):
            TrackingView(orderID: orderID)
        case .wallet:
            WalletView()
        case .savings:
            SavingsView()
        case .settings:
            SettingsView()
        }
    }
}
