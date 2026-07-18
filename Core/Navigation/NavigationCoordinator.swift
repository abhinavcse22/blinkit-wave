import Observation
import SwiftUI

/// Central navigation authority for Blinkit Wave.
///
/// Owns tab selection and per-tab `NavigationPath` stacks. All in-app and
/// external navigation flows through this coordinator to keep routing consistent.
@Observable
final class NavigationCoordinator {

    // MARK: - State

    private(set) var selectedTab: AppTab = .home
    private var tabPaths: [AppTab: NavigationPath]

    /// Navigation requests received before the view hierarchy is ready.
    private(set) var pendingRequest: NavigationRequest?

    // MARK: - Init

    init() {
        tabPaths = Dictionary(uniqueKeysWithValues: AppTab.allCases.map { ($0, NavigationPath()) })
    }

    // MARK: - Path Access

    func path(for tab: AppTab) -> NavigationPath {
        tabPaths[tab] ?? NavigationPath()
    }

    func setPath(_ path: NavigationPath, for tab: AppTab) {
        tabPaths[tab] = path
    }

    func binding(for tab: AppTab) -> Binding<NavigationPath> {
        Binding(
            get: { self.path(for: tab) },
            set: { self.setPath($0, for: tab) }
        )
    }

    // MARK: - Navigation

    /// Navigates to a destination, switching tabs and pushing as needed.
    func navigate(to destination: AppDestination) {
        let tab = destination.preferredTab

        if selectedTab != tab {
            selectedTab = tab
        }

        if destination.isStackDestination {
            var path = path(for: tab)
            path.append(destination)
            setPath(path, for: tab)
        } else {
            setPath(NavigationPath(), for: tab)
        }
    }

    /// Pops the top destination from the current tab's stack.
    func pop() {
        var path = path(for: selectedTab)
        guard !path.isEmpty else { return }
        path.removeLast()
        setPath(path, for: selectedTab)
    }

    /// Clears the current tab's navigation stack.
    func popToRoot() {
        setPath(NavigationPath(), for: selectedTab)
    }

    /// Clears every tab's navigation stack and returns to the home tab.
    func popAllToRoot() {
        for tab in AppTab.allCases {
            setPath(NavigationPath(), for: tab)
        }
        selectedTab = .home
    }

    /// Replaces the entire current tab stack with a single destination.
    func replace(with destination: AppDestination) {
        let tab = destination.preferredTab
        selectedTab = tab

        if destination.isStackDestination {
            var path = NavigationPath()
            path.append(destination)
            setPath(path, for: tab)
        } else {
            setPath(NavigationPath(), for: tab)
        }
    }

    /// Switches tabs without modifying stack state.
    func selectTab(_ tab: AppTab) {
        selectedTab = tab
    }

    // MARK: - External Navigation

    /// Handles a universal navigation request from any app entry point.
    func handle(_ request: NavigationRequest) {
        guard let destination = resolve(request) else { return }
        navigate(to: destination)
    }

    /// Stores a request when navigation cannot run immediately (e.g. cold launch).
    func enqueue(_ request: NavigationRequest) {
        pendingRequest = request
    }

    /// Drains and executes a pending request once the UI is ready.
    func consumePendingRequestIfNeeded() {
        guard let request = pendingRequest else { return }
        pendingRequest = nil
        handle(request)
    }

    /// Handles an incoming deep-link URL from widgets, Live Activities, or universal links.
    func handle(url: URL) {
        handle(.url(url))
    }

    /// Handles a push notification payload.
    func handleNotification(userInfo: [AnyHashable: Any]) {
        let stringPayload = userInfo.reduce(into: [String: String]()) { result, entry in
            if let key = entry.key as? String, let value = entry.value as? String {
                result[key] = value
            }
        }
        handle(.notification(userInfo: stringPayload))
    }

    /// Handles a Siri App Intent or other external navigation intent.
    func handle(intent: ExternalNavigationIntent, parameters: [String: String] = [:]) {
        handle(.externalIntent(intent, parameters: parameters))
    }

    // MARK: - Private

    private func resolve(_ request: NavigationRequest) -> AppDestination? {
        switch request {
        case .destination(let destination):
            return destination
        case .url(let url):
            return DeepLinkParser.destination(from: url)
        case .notification(let userInfo):
            return DeepLinkParser.destination(fromNotification: userInfo)
        case .externalIntent(let intent, let parameters):
            return DeepLinkParser.destination(from: intent, parameters: parameters)
        }
    }
}
