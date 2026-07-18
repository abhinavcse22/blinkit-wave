import SwiftUI

// MARK: - Design System View Extensions

extension View {

    // MARK: Backgrounds

    /// Fills the view with the design-system background color.
    func appBackground() -> some View {
        modifier(AppThemedBackgroundModifier(role: .background))
    }

    /// Fills the view with the design-system surface color.
    func appSurfaceBackground() -> some View {
        modifier(AppThemedBackgroundModifier(role: .surface))
    }

    // MARK: Layout

    /// Applies horizontal screen-edge padding using the standard `md` spacing token.
    func appHorizontalPadding(_ amount: CGFloat = AppSpacing.md) -> some View {
        padding(.horizontal, amount)
    }

    /// Applies vertical section spacing using the standard `lg` spacing token.
    func appSectionSpacing(_ amount: CGFloat = AppSpacing.lg) -> some View {
        padding(.vertical, amount)
    }

    /// Clips content to a continuous rounded rectangle using a corner-radius token.
    func appCornerRadius(_ radius: CGFloat) -> some View {
        clipShape(RoundedRectangle(cornerRadius: radius, style: .continuous))
    }

    // MARK: Animation

    /// Animates changes using the design-system smooth preset.
    func appSmoothAnimation<V: Equatable>(value: V) -> some View {
        animation(AppAnimation.smooth, value: value)
    }

    /// Animates changes using the design-system spring preset.
    func appSpringAnimation<V: Equatable>(value: V) -> some View {
        animation(AppAnimation.spring, value: value)
    }

    /// Animates changes using the design-system bounce preset.
    func appBounceAnimation<V: Equatable>(value: V) -> some View {
        animation(AppAnimation.bounce, value: value)
    }

    // MARK: Interaction

    /// Applies a subtle press-scale effect for tappable custom views.
    func appPressScale(isPressed: Bool, scale: CGFloat = 0.98) -> some View {
        scaleEffect(isPressed ? scale : 1)
            .animation(AppAnimation.spring, value: isPressed)
    }

    /// Adds a standard accessibility label and hint wrapper for custom controls.
    func appAccessibility(
        label: String,
        hint: String? = nil,
        traits: AccessibilityTraits = []
    ) -> some View {
        accessibilityElement(children: .ignore)
            .accessibilityLabel(label)
            .accessibilityHint(hint ?? "")
            .accessibilityAddTraits(traits)
    }
}

// MARK: - Themed Background

private enum AppSurfaceRole {
    case background
    case surface
}

private struct AppThemedBackgroundModifier: ViewModifier {

    @Environment(\.colorScheme) private var colorScheme

    let role: AppSurfaceRole

    func body(content: Content) -> some View {
        content.background(backgroundColor.ignoresSafeArea())
    }

    private var backgroundColor: Color {
        switch role {
        case .background:
            AppColors.background(for: colorScheme)
        case .surface:
            AppColors.surface(for: colorScheme)
        }
    }
}
