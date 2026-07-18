import SwiftUI

// MARK: - Card Style

/// Configuration for the reusable card surface modifier.
struct AppCardStyle {

    var cornerRadius: CGFloat = AppCornerRadius.large
    var padding: CGFloat = AppSpacing.md
    var shadow: AppShadow = AppShadow.medium
    var borderColor: Color?
    var borderWidth: CGFloat = 1

    static let `default` = AppCardStyle()
    static let elevated = AppCardStyle(shadow: AppShadow.large)
    static let flat = AppCardStyle(shadow: .none)
}

struct AppCardModifier: ViewModifier {

    @Environment(\.colorScheme) private var colorScheme

    let style: AppCardStyle

    func body(content: Content) -> some View {
        content
            .padding(style.padding)
            .background(
                RoundedRectangle(cornerRadius: style.cornerRadius, style: .continuous)
                    .fill(AppColors.card(for: colorScheme))
            )
            .overlay {
                if let borderColor = style.borderColor {
                    RoundedRectangle(cornerRadius: style.cornerRadius, style: .continuous)
                        .strokeBorder(borderColor, lineWidth: style.borderWidth)
                }
            }
            .appShadow(style.shadow)
    }
}

extension View {

    /// Applies the design-system card surface treatment.
    func appCardStyle(_ style: AppCardStyle = .default) -> some View {
        modifier(AppCardModifier(style: style))
    }
}
