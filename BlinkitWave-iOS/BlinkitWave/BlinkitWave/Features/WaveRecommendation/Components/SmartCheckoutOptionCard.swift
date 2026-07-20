import SwiftUI

/// A single Smart Checkout option — Community Batch, Scheduled Wave, Wallet
/// Top-up, or Instant Delivery — rendered from real Smart Wave Engine output.
///
/// Plain, rounded, Blinkit-style card. No glass, no gradients, no hero framing.
struct SmartCheckoutOptionCard: View {
    let option: DeliveryOption
    let recommendation: WaveRecommendation
    let cartSubtotal: Double
    let walletBalance: Double
    let isRecommended: Bool
    let isSelected: Bool
    let onSelect: () -> Void

    private var threshold: Double {
        EngineConfiguration.defaultConfiguration.freeDeliveryThreshold
    }

    var body: some View {
        Button(action: onSelect) {
            VStack(alignment: .leading, spacing: AppSpacing.md) {
                header
                Divider()
                content
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .appCardStyle(
                AppCardStyle(
                    shadow: .small,
                    borderColor: isSelected ? AppColors.secondary : nil,
                    borderWidth: 2
                )
            )
        }
        .buttonStyle(.plain)
    }

    // MARK: - Header

    private var header: some View {
        HStack(spacing: AppSpacing.sm) {
            Image(systemName: iconName)
                .foregroundStyle(AppColors.secondary)

            Text(title)
                .font(AppTypography.body.font)
                .fontWeight(.bold)
                .foregroundStyle(.primary)

            Spacer()

            if isRecommended {
                Text("RECOMMENDED")
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundStyle(AppColors.secondary)
                    .padding(.horizontal, AppSpacing.sm)
                    .padding(.vertical, 4)
                    .background(AppColors.primary, in: Capsule())
            }

            Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                .font(.title3)
                .foregroundStyle(isSelected ? AppColors.secondary : Color(.systemGray3))
        }
    }

    // MARK: - Content

    @ViewBuilder
    private var content: some View {
        switch option {
        case .liveWave:
            communityBatchContent
        case .scheduledWave:
            scheduledWaveContent
        case .smartWallet:
            walletTopUpContent
        case .instant(let fee):
            instantContent(fee: fee)
        }
    }

    private var communityBatchContent: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            fieldGrid([
                ("Cart Value", "₹\(Int(cartSubtotal))"),
                ("Target", "₹\(Int(threshold))"),
                ("Community Total", "₹\(Int(recommendation.batchResult.combinedValue))")
            ])

            Text("\(recommendation.batchResult.ordersInBatch.count) nearby shopper(s) already joined")
                .font(AppTypography.caption.font)
                .foregroundStyle(.secondary)

            footerRow(
                deliveryBy: recommendation.estimatedETA,
                isFree: recommendation.isFreeDelivery,
                savings: recommendation.estimatedSavings
            )
        }
    }

    private var scheduledWaveContent: some View {
        let slot = recommendation.predictedWaveSlot
        return VStack(alignment: .leading, spacing: AppSpacing.sm) {
            fieldGrid([
                ("Cart Value", "₹\(Int(cartSubtotal))"),
                ("Predicted Slot", formattedTime(slot.startTime)),
                ("Predicted Orders", "\(slot.predictedOrderCount)")
            ])

            Text("\(slot.predictedConfidence.rawValue.capitalized) confidence this slot unlocks free delivery")
                .font(AppTypography.caption.font)
                .foregroundStyle(.secondary)

            footerRow(
                deliveryBy: slot.startTime,
                isFree: slot.predictedConfidence == .high,
                savings: slot.estimatedDeliveryDiscount
            )
        }
    }

    private var walletTopUpContent: some View {
        let topUp = max(0.0, threshold - cartSubtotal)
        return VStack(alignment: .leading, spacing: AppSpacing.sm) {
            fieldGrid([
                ("Cart", "₹\(Int(cartSubtotal))"),
                ("Top-up", "₹\(Int(topUp))"),
                ("Wallet After", "₹\(Int(walletBalance + topUp))")
            ])

            Text("Future orders automatically use your wallet balance.")
                .font(AppTypography.caption.font)
                .foregroundStyle(.secondary)
        }
    }

    private func instantContent(fee: Double) -> some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            fieldGrid([
                ("Delivery Time", "10 min"),
                ("Delivery Fee", "₹\(Int(fee))")
            ])

            Text("The Blinkit experience you already know — nothing changes.")
                .font(AppTypography.caption.font)
                .foregroundStyle(.secondary)
        }
    }

    // MARK: - Shared pieces

    private func fieldGrid(_ fields: [(String, String)]) -> some View {
        HStack(spacing: AppSpacing.lg) {
            ForEach(fields, id: \.0) { field in
                VStack(alignment: .leading, spacing: 2) {
                    Text(field.0.uppercased())
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                    Text(field.1)
                        .font(AppTypography.body.font)
                        .fontWeight(.bold)
                }
            }
            Spacer()
        }
    }

    private func footerRow(deliveryBy: Date, isFree: Bool, savings: Double) -> some View {
        HStack {
            Label("Delivery before \(formattedTime(deliveryBy))", systemImage: "clock")
                .font(.caption2)
                .foregroundStyle(.secondary)
            Spacer()
            Text(isFree ? "FREE Delivery" : "Save ₹\(Int(savings))")
                .font(.caption2)
                .fontWeight(.bold)
                .foregroundStyle(AppColors.success)
        }
    }

    // MARK: - Helpers

    private var title: String {
        switch option {
        case .liveWave: return "Community Batch"
        case .scheduledWave: return "Scheduled Wave"
        case .smartWallet: return "Wallet Top-up"
        case .instant: return "Instant Delivery"
        }
    }

    private var iconName: String {
        switch option {
        case .liveWave: return "person.3.fill"
        case .scheduledWave: return "calendar.badge.clock"
        case .smartWallet: return "wallet.pass.fill"
        case .instant: return "bolt.fill"
        }
    }

    private func formattedTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
