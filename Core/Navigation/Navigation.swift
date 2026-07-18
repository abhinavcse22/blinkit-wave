import Foundation

/// Namespace for the Blinkit Wave navigation module.
///
/// ```
/// Core/Navigation/
/// ├── AppDestination.swift          → Hashable route enum
/// ├── AppTab.swift                  → Tab bar sections
/// ├── NavigationCoordinator.swift   → Path + tab state owner
/// ├── AppRouter.swift               → Destination → View mapping
/// ├── DeepLink/
/// │   ├── NavigationRequest.swift   → Unified external entry points
/// │   └── DeepLinkParser.swift      → URL / notification / intent parsing
/// ├── Placeholders/
/// │   └── DestinationPlaceholderView.swift
/// └── Root/
///     └── AppNavigationRoot.swift   → TabView + NavigationStack shell
/// ```
enum Navigation {}
