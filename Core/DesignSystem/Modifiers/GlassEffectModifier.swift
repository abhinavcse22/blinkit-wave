import SwiftUI

// MARK: - Glass Style

/// Configuration for the reusable glass / material surface modifier.
struct AppGlassStyle {

    var cornerRadius: CGFloat = AppCornerRadius.large
    var padding: CGFloat = AppSpacing.md
    var tint: Color?
    var isInteractive: Bool = false
    var shadow: AppShadow = AppShadow.small

    static let `default` = AppGlassStyle()
    static let prominent = AppGlassStyle(
        tint: AppColors.primary.opacity(0.15),
        shadow: AppShadow.medium
    )
    static let interactive = AppGlassStyle(isInteractive: true)
}

struct AppGlassEffectModifier: ViewModifier {

    let style: AppGlassStyle

    func body(content: Content) -> some View {
        styledContent(for: content)
            .appShadow(style.shadow)
    }

    @ViewBuilder
    private func styledContent(for content: Content) -> some View {
        let padded = content.padding(style.padding)
        let shape = RoundedRectangle(cornerRadius: style.cornerRadius, style: .continuous)

        if #available(iOS 26.0, *) {
            padded.glassEffect(glassVariant, in: shape)
        } else {
            padded
                .background(.ultraThinMaterial, in: shape)
                .overlay {
                    shape.strokeBorder(.white.opacity(0.25), lineWidth: 0.5)
                }
        }
    }

    @available(iOS 26.0, *)
    private var glassVariant: Glass {
        var glass = Glass.regular
        if let tint = style.tint {
            glass = glass.tint(tint)
        }
        if style.isInteractive {
            glass = glass.interactive()
        }
        return glass
    }
}

extension View {

    /// Applies a glass surface aligned with Apple's Liquid Glass on iOS 26+.
    ///
    /// Apply this modifier after layout modifiers such as padding and frame.
    func appGlassEffect(_ style: AppGlassStyle = .default) -> some View {
        modifier(AppGlassEffectModifier(style: style))
    }
}
