import SwiftUI

/// A currency figure that rolls up/down using the native numeric content transition
/// whenever its underlying value changes, instead of snapping instantly.
struct AnimatedRupeeText: View {
    let value: Double
    var font: AppTextStyle = AppTypography.title
    var color: Color = .primary

    var body: some View {
        Text("₹\(Int(value))")
            .appTextStyle(font, color: color)
            .contentTransition(.numericText(value: value))
            .animation(AppAnimation.smooth, value: value)
    }
}

/// A plain integer count that rolls using the native numeric content transition.
struct AnimatedCountText: View {
    let value: Int
    var font: AppTextStyle = AppTypography.title
    var color: Color = .primary

    var body: some View {
        Text("\(value)")
            .appTextStyle(font, color: color)
            .contentTransition(.numericText(value: Double(value)))
            .animation(AppAnimation.smooth, value: value)
    }
}
