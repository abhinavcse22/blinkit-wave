import SwiftUI

/// Animation presets for consistent, premium motion across the app.
enum AppAnimation {

    /// Standard ease-in-out for general transitions.
    static let smooth = Animation.smooth(duration: 0.35)

    /// Natural spring for interactive elements.
    static let spring = Animation.spring(
        response: 0.45,
        dampingFraction: 0.82,
        blendDuration: 0
    )

    /// Playful bounce for emphasis and delight moments.
    static let bounce = Animation.spring(
        response: 0.55,
        dampingFraction: 0.62,
        blendDuration: 0
    )
}
