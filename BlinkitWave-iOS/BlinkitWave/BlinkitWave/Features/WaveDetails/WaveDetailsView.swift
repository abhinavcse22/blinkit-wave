import SwiftUI

/// Premium, high-fidelity Wave Details Screen for Blinkit Wave.
struct WaveDetailsView: View {
    let waveID: String?
    
    @State private var viewModel = WaveDetailsViewModel()
    @Environment(NavigationCoordinator.self) private var coordinator

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: AppSpacing.lg) {
                if viewModel.isLoading {
                    ProgressView("Analyzing wave details...")
                        .frame(height: 200)
                } else if let wave = viewModel.wave {
                    // Header Status card
                    headerStatusCard(wave: wave)
                    
                    // Clustered Progress Card
                    progressCard(wave: wave)
                    
                    // Participants List Card
                    participantsSection(wave: wave)
                } else {
                    Text("Wave details are unavailable.")
                        .font(AppTypography.caption.font)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(.top, AppSpacing.md)
            .padding(.bottom, AppSpacing.xxl)
        }
        .appBackground()
        .navigationTitle("Wave Details")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadWave(byID: waveID)
        }
    }

    // MARK: - Subviews

    private func headerStatusCard(wave: Wave) -> some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            HStack {
                Text(wave.type == .live ? "🌊 LIVE WAVE" : "📅 SCHEDULED WAVE")
                    .font(AppTypography.caption.font)
                    .fontWeight(.bold)
                    .foregroundStyle(AppColors.primary)
                Spacer()
                
                Text(wave.status.rawValue.uppercased())
                    .font(AppTypography.caption.font)
                    .fontWeight(.bold)
                    .foregroundStyle(AppColors.accent)
            }
            
            Text("Leaving in 8 min")
                .font(AppTypography.title.font)
                .fontWeight(.bold)
            
            HStack(spacing: AppSpacing.md) {
                Label("CONFIDENCE: HIGH", systemImage: "chart.bar.fill")
                    .font(AppTypography.caption.font)
                    .foregroundStyle(AppColors.success)
                
                Label("SAVINGS: ₹35", systemImage: "indianrupeesign.circle.fill")
                    .font(AppTypography.caption.font)
                    .foregroundStyle(AppColors.primary)
            }
        }
        .appCardStyle(.elevated)
        .appHorizontalPadding()
    }

    private func progressCard(wave: Wave) -> some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            Text("Fulfillment Assembly")
                .font(AppTypography.headline.font)
            
            Text("Clustering orders in your sector to reach free delivery thresholds.")
                .font(AppTypography.caption.font)
                .foregroundStyle(.secondary)
            
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color(.systemGray5))
                        .frame(height: 8)
                    Capsule()
                        .fill(AppColors.primary)
                        .frame(width: geo.size.width * CGFloat(viewModel.progressPercent), height: 8)
                }
            }
            .frame(height: 8)
            .padding(.vertical, AppSpacing.xs)
            
            HStack {
                Text("\(Int(viewModel.progressPercent * 100))% Clustered")
                    .font(AppTypography.caption.font)
                    .fontWeight(.bold)
                    .foregroundStyle(AppColors.primary)
                
                Spacer()
                
                Text("Threshold: ₹150")
                    .font(AppTypography.caption.font)
                    .foregroundStyle(.secondary)
            }
        }
        .appCardStyle(.default)
        .appHorizontalPadding()
    }

    private func participantsSection(wave: Wave) -> some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            Text("Clustered Participants")
                .font(AppTypography.headline.font)
            
            VStack(spacing: 0) {
                ForEach(0..<viewModel.participantsCount, id: \.self) { idx in
                    HStack {
                        Image(systemName: "person.crop.circle.fill")
                            .font(.title2)
                            .foregroundStyle(AppColors.primary.opacity(0.6))
                        
                        VStack(alignment: .leading, spacing: AppSpacing.xs) {
                            Text(idx == 0 ? "You (Gupta Apartment)" : "Sector 62 Neighbor \(idx)")
                                .font(AppTypography.caption.font)
                                .fontWeight(idx == 0 ? .bold : .semibold)
                            Text("Clustered matches: Fruits & Dairy")
                                .font(AppTypography.caption.font)
                                .foregroundStyle(.secondary)
                        }
                        
                        Spacer()
                        
                        Text(idx == 0 ? "Joined" : "Matched")
                            .font(AppTypography.caption.font)
                            .fontWeight(.semibold)
                            .foregroundStyle(idx == 0 ? AppColors.success : .secondary)
                    }
                    .padding(.vertical, AppSpacing.sm)
                    
                    if idx != viewModel.participantsCount - 1 {
                        Divider()
                    }
                }
            }
            .appCardStyle(.flat)
        }
        .appHorizontalPadding()
    }
}
