import SwiftUI

/// Premium, high-fidelity Savings and Environmental Impact Dashboard for Blinkit Wave.
struct SavingsView: View {
    @State private var viewModel = SavingsViewModel()
    @Environment(NavigationCoordinator.self) private var coordinator

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: AppSpacing.lg) {
                // Cash Savings Card
                cashSavingsCard
                
                // Environmental Impact Card (Carbon footprint)
                environmentalImpactCard
                
                // Detailed breakdown list
                breakdownList
            }
            .padding(.top, AppSpacing.md)
            .padding(.bottom, AppSpacing.xxl)
        }
        .appBackground()
        .navigationTitle("My Savings")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadSavings()
        }
    }

    // MARK: - Subviews

    private var cashSavingsCard: some View {
        VStack(spacing: AppSpacing.md) {
            Label("TOTAL CASH SAVED", systemImage: "indianrupeesign.circle.fill")
                .font(AppTypography.caption.font)
                .fontWeight(.bold)
                .foregroundStyle(AppColors.primary)
            
            Text("₹\(Int(viewModel.totalSavings))")
                .font(.system(size: 46, weight: .bold))
                .foregroundStyle(.primary)
            
            Text("Aggregated delivery charge waivers across \(viewModel.wavesJoinedCount) shared waves.")
                .font(AppTypography.caption.font)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, AppSpacing.sm)
        }
        .frame(maxWidth: .infinity)
        .appCardStyle(.elevated)
        .appHorizontalPadding()
    }

    private var environmentalImpactCard: some View {
        VStack(alignment: .leading, spacing: AppSpacing.md) {
            Label("ENVIRONMENTAL CO2 SAVINGS", systemImage: "leaf.fill")
                .font(AppTypography.caption.font)
                .fontWeight(.bold)
                .foregroundStyle(AppColors.success)
            
            HStack(spacing: AppSpacing.xl) {
                VStack(alignment: .leading, spacing: AppSpacing.xs) {
                    Text(String(format: "%.1f kg", viewModel.carbonReducedKg))
                        .font(AppTypography.largeTitle.font)
                        .fontWeight(.bold)
                    Text("CO2 Reduced")
                        .font(AppTypography.caption.font)
                        .foregroundStyle(.secondary)
                }
                
                VStack(alignment: .leading, spacing: AppSpacing.xs) {
                    Text("\(viewModel.tripsSaved)")
                        .font(AppTypography.largeTitle.font)
                        .fontWeight(.bold)
                    Text("Rider Trips Saved")
                        .font(AppTypography.caption.font)
                        .foregroundStyle(.secondary)
                }
            }
            
            Divider()
            
            Text("By bundling orders into clustered neighborhood delivery waves, Blinkit Wave significantly reduces traffic congestion and carbon footprints.")
                .font(AppTypography.caption.font)
                .foregroundStyle(.secondary)
                .lineSpacing(2)
        }
        .appCardStyle(.default)
        .appHorizontalPadding()
    }

    private var breakdownList: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            Text("Savings Insights")
                .font(AppTypography.headline.font)
            
            VStack(spacing: 0) {
                insightRow(title: "Avg. Savings per Wave", value: "₹35")
                Divider()
                insightRow(title: "Wave Adoption Rate", value: "87%")
                Divider()
                insightRow(title: "Preferred Slot", value: "6:30 PM")
            }
            .appCardStyle(.flat)
        }
        .appHorizontalPadding()
    }

    private func insightRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
                .font(AppTypography.caption.font)
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
                .font(AppTypography.body.font)
                .fontWeight(.bold)
        }
        .padding(.vertical, AppSpacing.sm)
    }
}
