import SwiftUI

/// Premium, high-fidelity Wallet Screen for Blinkit Wave.
struct WalletView: View {
    @State private var viewModel = WalletViewModel()
    @Environment(NavigationCoordinator.self) private var coordinator

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: AppSpacing.lg) {
                // Wallet Balance Card
                balanceCard
                
                // Savings Statistics Overview
                savingsStatisticsCard
                
                // Auto-topup settings Card
                autoTopupSettingsCard
                
                // Transaction History List
                transactionsHistoryList
                
                // Order History List
                orderHistorySection
            }
            .padding(.top, AppSpacing.md)
            .padding(.bottom, AppSpacing.xxl)
        }
        .appBackground()
        .navigationTitle("Smart Wallet")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadWalletData()
        }
    }

    // MARK: - Subviews

    private var balanceCard: some View {
        VStack(spacing: AppSpacing.md) {
            HStack {
                VStack(alignment: .leading, spacing: AppSpacing.xs) {
                    Text("CURRENT BALANCE")
                        .font(AppTypography.caption.font)
                        .foregroundStyle(.secondary)
                    
                    Text("₹\(Int(viewModel.wallet?.balance ?? 0.0))")
                        .font(.system(size: 38, weight: .bold))
                        .foregroundStyle(.primary)
                }
                Spacer()
                
                Image(systemName: "wallet.pass.fill")
                    .font(.largeTitle)
                    .foregroundStyle(AppColors.primary)
            }
            
            Divider()
            
            // Quick Deposit buttons
            VStack(alignment: .leading, spacing: AppSpacing.xs) {
                Text("QUICK TOP-UP")
                    .font(AppTypography.caption.font)
                    .foregroundStyle(.secondary)
                
                HStack(spacing: AppSpacing.md) {
                    Button {
                        Task { await viewModel.deposit(amount: 150.0) }
                    } label: {
                        Text("+ ₹150")
                            .font(AppTypography.caption.font)
                            .fontWeight(.bold)
                    }
                    .buttonStyle(.appOutlined)
                    
                    Button {
                        Task { await viewModel.deposit(amount: 500.0) }
                    } label: {
                        Text("+ ₹500")
                            .font(AppTypography.caption.font)
                            .fontWeight(.bold)
                    }
                    .buttonStyle(.appPrimary)
                }
            }
        }
        .appCardStyle(.elevated)
        .appHorizontalPadding()
    }

    private var savingsStatisticsCard: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            Label("LIFETIME WAVE SAVINGS", systemImage: "sparkles")
                .font(AppTypography.caption.font)
                .fontWeight(.bold)
                .foregroundStyle(AppColors.primary)
            
            HStack(spacing: AppSpacing.xl) {
                VStack(alignment: .leading, spacing: AppSpacing.xs) {
                    Text("₹\(Int(viewModel.totalSavings))")
                        .font(AppTypography.largeTitle.font)
                        .fontWeight(.bold)
                    Text("Saved on Fees")
                        .font(AppTypography.caption.font)
                        .foregroundStyle(.secondary)
                }
                
                VStack(alignment: .leading, spacing: AppSpacing.xs) {
                    Text("\(viewModel.wavesJoinedCount)")
                        .font(AppTypography.largeTitle.font)
                        .fontWeight(.bold)
                    Text("Waves Joined")
                        .font(AppTypography.caption.font)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .appCardStyle(.default)
        .appHorizontalPadding()
    }

    private var autoTopupSettingsCard: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            Toggle(isOn: $viewModel.isAutoTopupEnabled) {
                VStack(alignment: .leading, spacing: AppSpacing.xs) {
                    Text("Auto-deposit Buffer")
                        .font(AppTypography.body.font)
                        .fontWeight(.bold)
                    Text("Instantly adds checkout differences to meeting the ₹\(Int(viewModel.autoTopupThreshold)) wave thresholds.")
                        .font(AppTypography.caption.font)
                        .foregroundStyle(.secondary)
                }
            }
            .tint(AppColors.primary)
        }
        .appCardStyle(.default)
        .appHorizontalPadding()
    }

    private var transactionsHistoryList: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            Text("Transaction History")
                .font(AppTypography.headline.font)
            
            if let txs = viewModel.wallet?.transactions, !txs.isEmpty {
                VStack(spacing: 0) {
                    ForEach(txs.reversed()) { tx in
                        HStack {
                            VStack(alignment: .leading, spacing: AppSpacing.xs) {
                                Text(tx.transactionDescription)
                                    .font(AppTypography.caption.font)
                                    .fontWeight(.semibold)
                                Text(formattedDate(tx.date))
                                    .font(AppTypography.caption.font)
                                    .foregroundStyle(.secondary)
                            }
                            Spacer()
                            
                            Text(tx.amount > 0 ? "+ ₹\(Int(tx.amount))" : "- ₹\(Int(abs(tx.amount)))")
                                .font(AppTypography.body.font)
                                .fontWeight(.bold)
                                .foregroundStyle(tx.amount > 0 ? AppColors.success : .primary)
                        }
                        .padding(.vertical, AppSpacing.sm)
                        
                        if tx.id != txs.first?.id {
                            Divider()
                        }
                    }
                }
                .appCardStyle(.flat)
            } else {
                Text("No transactions found.")
                    .font(AppTypography.caption.font)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, AppSpacing.md)
            }
        }
        .appHorizontalPadding()
    }

    private var orderHistorySection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            Text("Order History")
                .font(AppTypography.headline.font)
            
            VStack(spacing: 0) {
                ForEach(OrderFixtures.all.prefix(5)) { order in
                    HStack {
                        VStack(alignment: .leading, spacing: AppSpacing.xs) {
                            Text("Order \(order.id)")
                                .font(AppTypography.caption.font)
                                .fontWeight(.bold)
                            Text("\(order.items.count) item(s) • \(order.status.rawValue.uppercased())")
                                .font(AppTypography.caption.font)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        
                        Text("₹\(Int(order.totalAmount))")
                            .font(AppTypography.body.font)
                            .fontWeight(.bold)
                    }
                    .padding(.vertical, AppSpacing.sm)
                    
                    if order.id != OrderFixtures.all.prefix(5).last?.id {
                        Divider()
                    }
                }
            }
            .appCardStyle(.flat)
        }
        .appHorizontalPadding()
    }

    // MARK: - Helpers
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
