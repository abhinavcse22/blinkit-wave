import SwiftUI

// MARK: - Semantic Colors

/// Semantic color tokens for Blinkit Wave.
/// Raw palette values live in `AppColorPalette` to avoid duplication across themes.
enum AppColors {

    // MARK: Brand

    static let primary = AppColorPalette.blinkitYellow
    static let secondary = AppColorPalette.blinkitBlack
    static let accent = AppColorPalette.amber400

    // MARK: Surfaces

    static func background(for colorScheme: ColorScheme) -> Color {
        colorScheme == .dark ? AppColorPalette.neutral950 : AppColorPalette.neutral50
    }

    static func surface(for colorScheme: ColorScheme) -> Color {
        colorScheme == .dark ? AppColorPalette.neutral900 : AppColorPalette.neutral100
    }

    static func card(for colorScheme: ColorScheme) -> Color {
        colorScheme == .dark ? AppColorPalette.neutral850 : .white
    }

    // MARK: Feedback

    static let success = AppColorPalette.green600
    static let warning = AppColorPalette.amber500
    static let error = AppColorPalette.red500
}

// MARK: - Raw Palette

/// Internal palette. Use `AppColors` semantic tokens in feature code.
enum AppColorPalette {

    // Blinkit Brand
    static let blinkitYellow = Color(red: 0.984, green: 0.804, blue: 0.024)
    static let blinkitBlack = Color(red: 0.07, green: 0.07, blue: 0.08)

    // Greens
    static let green500 = Color(red: 0.14, green: 0.52, blue: 0.22)
    static let green600 = Color(red: 0.11, green: 0.44, blue: 0.18)
    static let green700 = Color(red: 0.08, green: 0.36, blue: 0.15)

    // Amber
    static let amber400 = Color(red: 1.00, green: 0.76, blue: 0.03)
    static let amber500 = Color(red: 0.96, green: 0.62, blue: 0.04)

    // Red
    static let red500 = Color(red: 0.86, green: 0.20, blue: 0.18)

    // Neutrals
    static let neutral50 = Color(red: 0.98, green: 0.98, blue: 0.97)
    static let neutral100 = Color(red: 0.96, green: 0.96, blue: 0.95)
    static let neutral850 = Color(red: 0.16, green: 0.16, blue: 0.17)
    static let neutral900 = Color(red: 0.11, green: 0.11, blue: 0.12)
    static let neutral950 = Color(red: 0.07, green: 0.07, blue: 0.08)
}
