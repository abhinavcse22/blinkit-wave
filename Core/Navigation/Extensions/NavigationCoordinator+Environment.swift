import SwiftUI

private struct NavigationCoordinatorKey: EnvironmentKey {

    static let defaultValue: NavigationCoordinator? = nil
}

extension EnvironmentValues {

    /// The shared navigation coordinator injected at the app root.
    var navigationCoordinator: NavigationCoordinator? {
        get { self[NavigationCoordinatorKey.self] }
        set { self[NavigationCoordinatorKey.self] = newValue }
    }
}

extension View {

    /// Injects a navigation coordinator into the environment.
    func navigationCoordinator(_ coordinator: NavigationCoordinator) -> some View {
        environment(\.navigationCoordinator, coordinator)
            .environment(coordinator)
    }
}
