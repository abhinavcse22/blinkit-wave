import SwiftUI

/// Namespace for the Blinkit Wave Design System.
///
/// Import and use the individual modules directly — each token category lives in its
/// own file under `Core/DesignSystem/` for scalability and discoverability.
///
/// ```
/// Core/DesignSystem/
/// ├── Colors/          → AppColors, AppColorPalette
/// ├── Typography/      → AppTypography, AppTextStyle
/// ├── Spacing/         → AppSpacing
/// ├── CornerRadius/    → AppCornerRadius
/// ├── Shadows/         → AppShadow
/// ├── Animation/       → AppAnimation
/// ├── Buttons/         → AppPrimaryButtonStyle, …
/// ├── Modifiers/       → AppCardModifier, AppGlassEffectModifier
/// └── Extensions/      → View+DesignSystem
/// ```
enum DesignSystem {}
