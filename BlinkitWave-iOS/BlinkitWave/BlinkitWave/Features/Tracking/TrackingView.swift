import SwiftUI

/// Premium, high-fidelity Tracking Timeline Screen for Blinkit Wave.
struct TrackingView: View {
    let orderID: String
    
    @State private var viewModel = TrackingViewModel()
    @Environment(NavigationCoordinator.self) private var coordinator

    var body: some View {
        VStack(spacing: 0) {
            if viewModel.isLoading {
                ProgressView("Loading tracking data...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let order = viewModel.order {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: AppSpacing.lg) {
                        // Hero ETA Card
                        etaHeaderCard(order: order)
                        
                        // Active Timeline Stack
                        timelineSection
                        
                        // Order details Summary Card
                        orderSummaryCard(order: order)
                    }
                    .padding(.top, AppSpacing.md)
                }
                
                // Simulation developer actions bar
                simulationActionBar
            }
        }
        .appBackground()
        .navigationTitle("Track Order")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadOrder(byID: orderID)
        }
    }

    // MARK: - Subviews

    private func etaHeaderCard(order: Order) -> some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            HStack {
                VStack(alignment: .leading, spacing: AppSpacing.xs) {
                    Text("ESTIMATED DELIVERY")
                        .font(AppTypography.caption.font)
                        .foregroundStyle(.secondary)
                    
                    Text(formattedTime(order.deliveryDeadline))
                        .font(AppTypography.largeTitle.font)
                        .fontWeight(.bold)
                }
                Spacer()
                
                Image(systemName: "box.truck.badge.clock.fill")
                    .font(.largeTitle)
                    .foregroundStyle(AppColors.primary)
            }
            
            Text("Order ID: \(order.id)")
                .font(AppTypography.caption.font)
                .foregroundStyle(.secondary)
        }
        .appCardStyle(.elevated)
        .appHorizontalPadding()
    }

    private var timelineSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.md) {
            Text("Delivery Progress")
                .font(AppTypography.headline.font)
            
            VStack(alignment: .leading, spacing: 0) {
                ForEach(0..<viewModel.trackingSteps.count, id: \.self) { index in
                    let stepName = viewModel.trackingSteps[index]
                    let isActive = index <= viewModel.currentStepIndex
                    let isCurrent = index == viewModel.currentStepIndex
                    
                    HStack(alignment: .top, spacing: AppSpacing.md) {
                        // Vertical bullet indicator line
                        VStack(spacing: 0) {
                            Image(systemName: isCurrent ? "waveform.path" : (isActive ? "checkmark.circle.fill" : "circle.fill"))
                                .font(isCurrent ? .title3 : .body)
                                .foregroundStyle(isActive ? AppColors.primary : Color(.systemGray4))
                                .frame(width: 30, height: 30)
                                .background(Color(.systemBackground))
                            
                            if index != viewModel.trackingSteps.count - 1 {
                                Rectangle()
                                    .fill(isActive ? AppColors.primary : Color(.systemGray4))
                                    .frame(width: 3, height: 40)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: AppSpacing.xs) {
                            Text(stepName)
                                .font(AppTypography.body.font)
                                .fontWeight(isActive ? .bold : .regular)
                                .foregroundStyle(isActive ? .primary : .secondary)
                            
                            if isCurrent {
                                Text("Updated just now")
                                    .font(AppTypography.caption.font)
                                    .foregroundStyle(AppColors.primary)
                            }
                        }
                        .padding(.top, 4)
                        
                        Spacer()
                    }
                }
            }
        }
        .appCardStyle(.flat)
        .appHorizontalPadding()
    }

    private func orderSummaryCard(order: Order) -> some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            Text("Items Summary")
                .font(AppTypography.headline.font)
            
            ForEach(order.items) { item in
                if let product = item.product {
                    HStack {
                        Text("\(item.quantity)x \(product.name)")
                            .font(AppTypography.caption.font)
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text("₹\(Int(product.price * Double(item.quantity)))")
                            .font(AppTypography.caption.font)
                            .fontWeight(.semibold)
                    }
                }
            }
            Divider()
            
            HStack {
                Text("Subtotal")
                    .font(AppTypography.caption.font)
                    .foregroundStyle(.secondary)
                Spacer()
                Text("₹\(Int(order.subtotal))")
                    .font(AppTypography.caption.font)
            }
            HStack {
                Text("Delivery Charge")
                    .font(AppTypography.caption.font)
                    .foregroundStyle(.secondary)
                Spacer()
                Text(order.deliveryFee == 0.0 ? "FREE" : "₹\(Int(order.deliveryFee))")
                    .font(AppTypography.caption.font)
                    .foregroundStyle(order.deliveryFee == 0.0 ? AppColors.success : .primary)
            }
            HStack {
                Text("Total Paid")
                    .font(AppTypography.body.font)
                    .fontWeight(.bold)
                Spacer()
                Text("₹\(Int(order.totalAmount))")
                    .font(AppTypography.body.font)
                    .fontWeight(.bold)
            }
        }
        .appCardStyle(.default)
        .appHorizontalPadding()
    }

    private var simulationActionBar: some View {
        VStack(spacing: AppSpacing.sm) {
            Button {
                Task {
                    await viewModel.simulateProgress()
                }
            } label: {
                Label("Simulate Next Step", systemImage: "play.circle.fill")
                    .font(AppTypography.button.font)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.appPrimary)
            
            Button {
                coordinator.popAllToRoot()
            } label: {
                Text("Back to Home")
                    .font(AppTypography.button.font)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.appOutlined)
        }
        .padding(AppSpacing.md)
        .appGlassEffect()
    }

    // MARK: - Helpers
    
    private func formattedTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
