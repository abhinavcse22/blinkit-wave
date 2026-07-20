import SwiftUI

// MARK: - Primary

struct AppPrimaryButtonStyle: ButtonStyle {

    @Environment(\.isEnabled) private var isEnabled

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .appButtonText(color: .black.opacity(isEnabled ? 1 : 0.4))
            .frame(maxWidth: .infinity)
            .padding(.vertical, AppSpacing.sm + 2)
            .padding(.horizontal, AppSpacing.md)
            .background(
                RoundedRectangle(cornerRadius: AppCornerRadius.medium, style: .continuous)
                    .fill(AppColors.primary.opacity(isEnabled ? 1 : 0.4))
            )
            .appShadow(isEnabled ? AppShadow.small : AppShadow.none)
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(AppAnimation.spring, value: configuration.isPressed)
    }
}

// MARK: - Secondary

struct AppSecondaryButtonStyle: ButtonStyle {

    @Environment(\.isEnabled) private var isEnabled

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .appButtonText(color: .white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, AppSpacing.sm + 2)
            .padding(.horizontal, AppSpacing.md)
            .background(
                RoundedRectangle(cornerRadius: AppCornerRadius.medium, style: .continuous)
                    .fill(AppColors.secondary.opacity(isEnabled ? 1 : 0.4))
            )
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(AppAnimation.spring, value: configuration.isPressed)
    }
}

// MARK: - Outlined

struct AppOutlinedButtonStyle: ButtonStyle {

    @Environment(\.isEnabled) private var isEnabled

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .appButtonText(color: AppColors.primary.opacity(isEnabled ? 1 : 0.4))
            .frame(maxWidth: .infinity)
            .padding(.vertical, AppSpacing.sm + 2)
            .padding(.horizontal, AppSpacing.md)
            .background(
                RoundedRectangle(cornerRadius: AppCornerRadius.medium, style: .continuous)
                    .strokeBorder(
                        AppColors.primary.opacity(isEnabled ? 1 : 0.4),
                        lineWidth: 1.5
                    )
            )
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(AppAnimation.spring, value: configuration.isPressed)
    }
}

// MARK: - Ghost

struct AppGhostButtonStyle: ButtonStyle {

    @Environment(\.isEnabled) private var isEnabled

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .appButtonText(color: AppColors.primary.opacity(isEnabled ? 1 : 0.4))
            .frame(maxWidth: .infinity)
            .padding(.vertical, AppSpacing.sm + 2)
            .padding(.horizontal, AppSpacing.md)
            .background(
                RoundedRectangle(cornerRadius: AppCornerRadius.medium, style: .continuous)
                    .fill(configuration.isPressed ? AppColors.primary.opacity(0.08) : .clear)
            )
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(AppAnimation.spring, value: configuration.isPressed)
    }
}

// MARK: - Style Registry

extension ButtonStyle where Self == AppPrimaryButtonStyle {

    static var appPrimary: AppPrimaryButtonStyle { AppPrimaryButtonStyle() }
}

extension ButtonStyle where Self == AppSecondaryButtonStyle {

    static var appSecondary: AppSecondaryButtonStyle { AppSecondaryButtonStyle() }
}

extension ButtonStyle where Self == AppOutlinedButtonStyle {

    static var appOutlined: AppOutlinedButtonStyle { AppOutlinedButtonStyle() }
}

extension ButtonStyle where Self == AppGhostButtonStyle {

    static var appGhost: AppGhostButtonStyle { AppGhostButtonStyle() }
}
