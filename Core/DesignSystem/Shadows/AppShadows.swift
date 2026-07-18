import SwiftUI

// MARK: - Shadow Token

/// A reusable shadow definition for elevation hierarchy.
struct AppShadow {

    let color: Color
    let radius: CGFloat
    let x: CGFloat
    let y: CGFloat

    static let small = AppShadow(
        color: .black.opacity(0.08),
        radius: 4,
        x: 0,
        y: 2
    )

    static let medium = AppShadow(
        color: .black.opacity(0.12),
        radius: 8,
        x: 0,
        y: 4
    )

    static let large = AppShadow(
        color: .black.opacity(0.16),
        radius: 16,
        x: 0,
        y: 8
    )

    /// No shadow — for flat surfaces.
    static let none = AppShadow(
        color: .clear,
        radius: 0,
        x: 0,
        y: 0
    )
}

// MARK: - Modifier

struct AppShadowModifier: ViewModifier {

    let shadow: AppShadow

    func body(content: Content) -> some View {
        content.shadow(
            color: shadow.color,
            radius: shadow.radius,
            x: shadow.x,
            y: shadow.y
        )
    }
}

extension View {

    /// Applies a design-system shadow token.
    func appShadow(_ shadow: AppShadow) -> some View {
        modifier(AppShadowModifier(shadow: shadow))
    }
}
