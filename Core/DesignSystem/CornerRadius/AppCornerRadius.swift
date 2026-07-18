import CoreGraphics

/// Corner radius tokens for consistent shape language across the app.
enum AppCornerRadius {

    /// 6pt — chips, small badges
    static let small: CGFloat = 6

    /// 12pt — buttons, input fields
    static let medium: CGFloat = 12

    /// 16pt — cards, sheets
    static let large: CGFloat = 16

    /// 24pt — prominent containers, hero cards
    static let extraLarge: CGFloat = 24
}
