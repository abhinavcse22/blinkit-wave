import SwiftUI

// MARK: - Text Style

/// A reusable typographic style aligned with Apple's Dynamic Type scale.
struct AppTextStyle {

    let font: Font
    let weight: Font.Weight
    let lineSpacing: CGFloat
    let tracking: CGFloat

    init(
        textStyle: Font.TextStyle,
        weight: Font.Weight = .regular,
        lineSpacing: CGFloat = 0,
        tracking: CGFloat = 0
    ) {
        self.font = .system(textStyle, design: .default)
        self.weight = weight
        self.lineSpacing = lineSpacing
        self.tracking = tracking
    }

    init(
        size: CGFloat,
        weight: Font.Weight = .regular,
        lineSpacing: CGFloat = 0,
        tracking: CGFloat = 0
    ) {
        self.font = .system(size: size, weight: weight, design: .default)
        self.weight = weight
        self.lineSpacing = lineSpacing
        self.tracking = tracking
    }
}

// MARK: - Presets

enum AppTypography {

    static let largeTitle = AppTextStyle(
        textStyle: .largeTitle,
        weight: .bold,
        lineSpacing: 2
    )

    static let title = AppTextStyle(
        textStyle: .title,
        weight: .semibold,
        lineSpacing: 1
    )

    static let headline = AppTextStyle(
        textStyle: .headline,
        weight: .semibold
    )

    static let body = AppTextStyle(
        textStyle: .body,
        weight: .regular,
        lineSpacing: 4
    )

    static let caption = AppTextStyle(
        textStyle: .caption,
        weight: .regular,
        lineSpacing: 2
    )

    static let button = AppTextStyle(
        size: 17,
        weight: .semibold,
        tracking: 0.2
    )
}

// MARK: - Text Modifier

struct AppTextStyleModifier: ViewModifier {

    let style: AppTextStyle
    let color: Color

    func body(content: Content) -> some View {
        content
            .font(style.font.weight(style.weight))
            .tracking(style.tracking)
            .lineSpacing(style.lineSpacing)
            .foregroundStyle(color)
    }
}

extension View {

    /// Applies a design-system text style with an optional foreground color.
    func appTextStyle(
        _ style: AppTextStyle,
        color: Color = .primary
    ) -> some View {
        modifier(AppTextStyleModifier(style: style, color: color))
    }

    func appLargeTitle(color: Color = .primary) -> some View {
        appTextStyle(AppTypography.largeTitle, color: color)
    }

    func appTitle(color: Color = .primary) -> some View {
        appTextStyle(AppTypography.title, color: color)
    }

    func appHeadline(color: Color = .primary) -> some View {
        appTextStyle(AppTypography.headline, color: color)
    }

    func appBody(color: Color = .primary) -> some View {
        appTextStyle(AppTypography.body, color: color)
    }

    func appCaption(color: Color = .secondary) -> some View {
        appTextStyle(AppTypography.caption, color: color)
    }

    func appButtonText(color: Color = .primary) -> some View {
        appTextStyle(AppTypography.button, color: color)
    }
}
