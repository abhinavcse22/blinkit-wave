import SwiftUI

/// Premium Settings and Preferences View for Blinkit Wave.
struct SettingsView: View {
    @State private var viewModel = SettingsViewModel()
    @Environment(NavigationCoordinator.self) private var coordinator

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: AppSpacing.lg) {
                // Wave preferences Card
                wavePreferencesCard
                
                // Radius configuration Card
                radiusConfigCard
                
                // Notifications Card
                notificationsCard
            }
            .padding(.top, AppSpacing.md)
            .padding(.bottom, AppSpacing.xxl)
        }
        .appBackground()
        .navigationTitle("Preferences")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Subviews

    private var wavePreferencesCard: some View {
        VStack(alignment: .leading, spacing: AppSpacing.md) {
            Text("Wave Settings")
                .font(AppTypography.headline.font)
            
            Toggle("Auto-join Live Waves", isOn: $viewModel.autoJoinWaves)
                .font(AppTypography.body.font)
                .tint(AppColors.primary)
            
            Text("When checked, matching orders within delivery deadlines will automatically route to clustered waves for savings.")
                .font(AppTypography.caption.font)
                .foregroundStyle(.secondary)
            
            Divider()
            
            Stepper(value: $viewModel.defaultDeadlineMinutes, in: 30...360, step: 30) {
                HStack {
                    Text("Default Deadline Buffer")
                        .font(AppTypography.body.font)
                    Spacer()
                    Text("\(viewModel.defaultDeadlineMinutes) min")
                        .font(AppTypography.body.font)
                        .fontWeight(.bold)
                }
            }
        }
        .appCardStyle(.default)
        .appHorizontalPadding()
    }

    private var radiusConfigCard: some View {
        VStack(alignment: .leading, spacing: AppSpacing.md) {
            Text("Clustering Parameters")
                .font(AppTypography.headline.font)
            
            VStack(alignment: .leading, spacing: AppSpacing.xs) {
                HStack {
                    Text("Match Radius Limit")
                        .font(AppTypography.body.font)
                    Spacer()
                    Text("\(Int(viewModel.searchRadiusMeters)) m")
                        .font(AppTypography.body.font)
                        .fontWeight(.bold)
                }
                
                Slider(value: $viewModel.searchRadiusMeters, in: 100.0...1000.0, step: 50.0)
                    .tint(AppColors.primary)
            }
            
            Text("Adjusts neighborhood matching search ranges for order clustering optimization.")
                .font(AppTypography.caption.font)
                .foregroundStyle(.secondary)
        }
        .appCardStyle(.default)
        .appHorizontalPadding()
    }

    private var notificationsCard: some View {
        VStack(alignment: .leading, spacing: AppSpacing.md) {
            Text("Alert preferences")
                .font(AppTypography.headline.font)
            
            Toggle("Push Wave Notifications", isOn: $viewModel.enableSmartNotifications)
                .font(AppTypography.body.font)
                .tint(AppColors.primary)
            
            Text("Receive high-priority updates when a neighborhood wave forms, confirmations arise, or dispatches begin.")
                .font(AppTypography.caption.font)
                .foregroundStyle(.secondary)
        }
        .appCardStyle(.default)
        .appHorizontalPadding()
    }
}
