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
            DestinationPlaceholderView(
                title: "Home",
                systemImage: "house.fill"
            )
        case .product(let productID):
            DestinationPlaceholderView(
                title: "Product",
                subtitle: productID,
                systemImage: "bag.fill"
            )
        case .cart:
            DestinationPlaceholderView(
                title: "Cart",
                systemImage: "cart.fill"
            )
        case .waveRecommendation:
            DestinationPlaceholderView(
                title: "Wave Recommendation",
                systemImage: "waveform.path"
            )
        case .scheduledWave(let waveID):
            DestinationPlaceholderView(
                title: "Scheduled Wave",
                subtitle: waveID ?? "All waves",
                systemImage: "calendar.badge.clock"
            )
        case .tracking(let orderID):
            DestinationPlaceholderView(
                title: "Tracking",
                subtitle: orderID,
                systemImage: "location.fill"
            )
        case .wallet:
            DestinationPlaceholderView(
                title: "Wallet",
                systemImage: "wallet.pass.fill"
            )
        case .savings:
            DestinationPlaceholderView(
                title: "Savings",
                systemImage: "indianrupeesign.circle.fill"
            )
        case .settings:
            DestinationPlaceholderView(
                title: "Settings",
                systemImage: "gearshape.fill"
            )
        }
    }
}
