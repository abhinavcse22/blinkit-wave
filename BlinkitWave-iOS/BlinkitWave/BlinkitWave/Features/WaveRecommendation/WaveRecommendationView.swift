import SwiftUI

/// Checkout screen. This is the one place Smart Checkout appears — once a real
/// cart exists, it evaluates cart value, deadline, nearby demand, rider
/// availability, and wallet balance to recommend the best fulfillment option.
struct WaveRecommendationView: View {
    @State private var viewModel = WaveRecommendationViewModel()
    @Environment(NavigationCoordinator.self) private var coordinator

    @State private var isPickingDeadline = false
    @State private var pendingDeadline = Date(timeIntervalSinceNow: 7200)

    var body: some View {
        VStack(spacing: 0) {
            if viewModel.currentUser == nil {
                ProgressView("Analyzing delivery options...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: AppSpacing.lg) {
                        deadlineRow

                        smartCheckoutSection
                    }
                    .padding(.top, AppSpacing.md)
                }

                if let rec = viewModel.recommendation {
                    confirmBar(rec: rec)
                }
            }
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Checkout")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadRecommendation()
        }
        .onChange(of: viewModel.deliveryDeadline) { _, _ in
            Task {
                await viewModel.loadRecommendation()
            }
        }
        .onChange(of: viewModel.checkedOutOrderID) { _, orderID in
            if let orderID {
                coordinator.navigate(to: .tracking(orderID: orderID))
            }
        }
        .sheet(isPresented: $isPickingDeadline) {
            deadlineSheet
        }
    }

    // MARK: - Deadline

    private var deadlineRow: some View {
        Button {
            pendingDeadline = viewModel.deliveryDeadline
            isPickingDeadline = true
        } label: {
            HStack {
                Label("Need it by \(formattedTime(viewModel.deliveryDeadline))", systemImage: "clock")
                    .font(AppTypography.caption.font)
                    .fontWeight(.semibold)
                    .foregroundStyle(.primary)
                Spacer()
                Text("Change")
                    .font(AppTypography.caption.font)
                    .fontWeight(.semibold)
                    .foregroundStyle(AppColors.secondary)
            }
        }
        .buttonStyle(.plain)
        .appHorizontalPadding()
    }

    private var deadlineSheet: some View {
        NavigationStack {
            VStack {
                DatePicker(
                    "Need it by",
                    selection: $pendingDeadline,
                    in: Date()...(Date(timeIntervalSinceNow: 86400)),
                    displayedComponents: [.hourAndMinute]
                )
                .datePickerStyle(.wheel)
                .padding()

                Spacer()
            }
            .navigationTitle("Delivery Deadline")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { isPickingDeadline = false }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Set") {
                        isPickingDeadline = false
                        viewModel.deliveryDeadline = pendingDeadline
                    }
                    .fontWeight(.bold)
                }
            }
        }
        .presentationDetents([.height(320)])
    }

    // MARK: - Smart Checkout

    private var smartCheckoutSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            Text("Smart Checkout")
                .font(AppTypography.headline.font)
                .appHorizontalPadding()

            Text("Blinkit found a better way to fulfill your order.")
                .font(AppTypography.caption.font)
                .foregroundStyle(.secondary)
                .appHorizontalPadding()

            if let rec = viewModel.recommendation, let cart = viewModel.activeCart {
                VStack(spacing: AppSpacing.md) {
                    ForEach(checkoutOptions(for: rec), id: \.self) { option in
                        SmartCheckoutOptionCard(
                            option: option,
                            recommendation: rec,
                            cartSubtotal: cartSubtotal(cart),
                            walletBalance: viewModel.walletBalance,
                            isRecommended: option == rec.primaryRecommendation.recommendedOption,
                            isSelected: viewModel.selectedOption == option
                        ) {
                            viewModel.selectedOption = option
                        }
                    }
                }
                .appHorizontalPadding()
            } else {
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, AppSpacing.xl)
            }
        }
    }

    /// Builds the option list from whatever the engine actually returned —
    /// primary plus alternatives, de-duplicated by option. No fixed static grid.
    private func checkoutOptions(for rec: WaveRecommendation) -> [DeliveryOption] {
        var seen = Set<DeliveryOption>()
        var ordered: [DeliveryOption] = []

        for option in [rec.primaryRecommendation.recommendedOption] + rec.alternativeRecommendations.map(\.recommendedOption) {
            if !seen.contains(option) {
                seen.insert(option)
                ordered.append(option)
            }
        }
        return ordered
    }

    private func confirmBar(rec: WaveRecommendation) -> some View {
        VStack {
            Button {
                Task {
                    await viewModel.checkout()
                }
            } label: {
                HStack {
                    if viewModel.isCheckingOut {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .black))
                    } else {
                        Image(systemName: "creditcard.fill")
                        Text("Place Order • ₹\(Int(rec.batchResult.combinedValue - rec.estimatedSavings))")
                    }
                }
                .font(AppTypography.button.font)
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(.appPrimary)
            .disabled(viewModel.isCheckingOut)
        }
        .padding(AppSpacing.md)
        .background(
            Color(.systemBackground)
                .appShadow(.medium)
        )
    }

    // MARK: - Helpers

    private func cartSubtotal(_ cart: Cart) -> Double {
        cart.items.reduce(0.0) { sum, item in
            guard let product = item.product else { return sum }
            return sum + (product.price * Double(item.quantity))
        }
    }

    private func formattedTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
