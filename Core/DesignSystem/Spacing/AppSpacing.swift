import CoreGraphics

/// Spacing constants based on an 4pt grid, following HIG layout guidance.
enum AppSpacing {

    /// 4pt — tight inline spacing, icon gaps
    static let xs: CGFloat = 4

    /// 8pt — compact padding, list item spacing
    static let sm: CGFloat = 8

    /// 16pt — standard content padding
    static let md: CGFloat = 16

    /// 24pt — section spacing
    static let lg: CGFloat = 24

    /// 32pt — large section breaks
    static let xl: CGFloat = 32

    /// 48pt — hero spacing, major layout gaps
    static let xxl: CGFloat = 48
}
