import SwiftUI

/// Root navigation container wiring `TabView`, per-tab `NavigationStack`s,
/// and external deep-link handlers into the coordinator.
struct AppNavigationRoot: View {

    @State private var coordinator = NavigationCoordinator()

    var body: some View {
        TabView(selection: tabSelection) {
            ForEach(AppTab.allCases, id: \.self) { tab in
                tabStack(for: tab)
                    .tabItem {
                        Label(tab.title, systemImage: tab.systemImage)
                    }
                    .tag(tab)
            }
        }
        .environment(coordinator)
        .onOpenURL(perform: coordinator.handle(url:))
        .onAppear(perform: coordinator.consumePendingRequestIfNeeded)
    }

    // MARK: - Tab Stack

    @ViewBuilder
    private func tabStack(for tab: AppTab) -> some View {
        NavigationStack(path: coordinator.binding(for: tab)) {
            AppRouter.view(for: tab.rootDestination)
                .navigationDestination(for: AppDestination.self) { destination in
                    AppRouter.view(for: destination)
                }
        }
    }

    // MARK: - Tab Selection

    private var tabSelection: Binding<AppTab> {
        Binding(
            get: { coordinator.selectedTab },
            set: { coordinator.selectTab($0) }
        )
    }
}

// MARK: - Tab Presentation

private extension AppTab {

    var title: String {
        switch self {
        case .home: return "Home"
        case .cart: return "Cart"
        case .wave: return "Wave"
        case .wallet: return "Wallet"
        case .settings: return "Settings"
        }
    }

    var systemImage: String {
        switch self {
        case .home: return "house.fill"
        case .cart: return "cart.fill"
        case .wave: return "waveform.path"
        case .wallet: return "wallet.pass.fill"
        case .settings: return "gearshape.fill"
        }
    }
}
