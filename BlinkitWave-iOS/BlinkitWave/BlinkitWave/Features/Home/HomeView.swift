import SwiftUI

/// Premium, high-fidelity Home Dashboard View for Blinkit Wave.
///
/// This is a familiar, Blinkit-inspired shopping home: greeting, search,
/// categories, and products. Smart Wave is not a homepage feature — it
/// activates during checkout, once a real cart and deadline exist.
struct HomeView: View {
    @State private var viewModel = HomeViewModel()
    @Environment(NavigationCoordinator.self) private var coordinator

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: AppSpacing.lg) {
                // Greeting & Profile Header
                headerSection

                // Search Bar Hero Card
                searchBarSection

                // Quick Category Grid
                categoriesSection

                // Wallet & Savings Split Dashboard
                walletSavingsSection

                // Recommended Products Carousel
                recommendedProductsSection

                // Trending Items Grid
                trendingProductsSection
            }
            .padding(.bottom, AppSpacing.xxl)
        }
        .appBackground()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Text("Blinkit Wave")
                    .font(AppTypography.headline.font)
                    .foregroundStyle(AppColors.primary)
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    coordinator.navigate(to: .settings)
                } label: {
                    Image(systemName: "gearshape.fill")
                        .foregroundStyle(.secondary)
                }
                .buttonStyle(.plain)
            }
        }
        .task {
            await viewModel.loadData()
        }
    }

    // MARK: - Subsections

    private var headerSection: some View {
        HStack {
            VStack(alignment: .leading, spacing: AppSpacing.xs) {
                Text(viewModel.greeting)
                    .font(AppTypography.largeTitle.font)
                    .fontWeight(.bold)
                Text("Noida Sector 62 • ETA +10 min")
                    .font(AppTypography.caption.font)
                    .foregroundStyle(.secondary)
            }
            Spacer()

            Button {
                coordinator.navigate(to: .settings) // Settings acting as profile settings
            } label: {
                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 40))
                    .foregroundStyle(AppColors.primary)
            }
            .buttonStyle(.plain)
        }
        .appHorizontalPadding()
        .padding(.top, AppSpacing.sm)
    }

    private var searchBarSection: some View {
        Button {
            coordinator.navigate(to: .home) // Taps can trigger search overlay or search route
            // For routing convenience, search will handle suggestions
        } label: {
            HStack(spacing: AppSpacing.sm) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.secondary)
                Text("Search bread, milk, snacks...")
                    .font(AppTypography.body.font)
                    .foregroundStyle(.secondary)
                Spacer()
                Image(systemName: "mic.fill")
                    .foregroundStyle(AppColors.primary)
            }
            .appGlassEffect(.prominent)
        }
        .buttonStyle(.plain)
        .appHorizontalPadding()
    }

    private var categoriesSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            Text("Shop Categories")
                .font(AppTypography.headline.font)
                .appHorizontalPadding()

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: AppSpacing.md) {
                    ForEach(viewModel.categories) { category in
                        Button {
                            // Category selection triggers filtering
                        } label: {
                            VStack(spacing: AppSpacing.sm) {
                                Image(systemName: category.iconName)
                                    .font(.title2)
                                    .foregroundStyle(AppColors.primary)
                                    .frame(width: 50, height: 50)
                                    .background(AppColors.primary.opacity(0.1))
                                    .clipShape(Circle())

                                Text(category.name)
                                    .font(AppTypography.caption.font)
                                    .foregroundStyle(.primary)
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, AppSpacing.md)
            }
        }
    }

    private var walletSavingsSection: some View {
        HStack(spacing: AppSpacing.md) {
            // Wallet Card
            Button {
                coordinator.navigate(to: .wallet)
            } label: {
                VStack(alignment: .leading, spacing: AppSpacing.xs) {
                    Label("Wallet", systemImage: "wallet.pass.fill")
                        .font(AppTypography.caption.font)
                        .foregroundStyle(.secondary)

                    Text("₹\(Int(viewModel.walletBalance))")
                        .font(AppTypography.title.font)
                        .fontWeight(.bold)
                        .foregroundStyle(.primary)

                    Text("Auto-deposit active")
                        .font(AppTypography.caption.font)
                        .foregroundStyle(AppColors.success)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .appCardStyle(.default)
            }
            .buttonStyle(.plain)

            // Savings Card
            Button {
                coordinator.navigate(to: .savings)
            } label: {
                VStack(alignment: .leading, spacing: AppSpacing.xs) {
                    Label("Savings", systemImage: "indianrupeesign.circle.fill")
                        .font(AppTypography.caption.font)
                        .foregroundStyle(.secondary)

                    Text("₹\(Int(viewModel.totalSavings))")
                        .font(AppTypography.title.font)
                        .fontWeight(.bold)
                        .foregroundStyle(.primary)

                    Text("Saved over 7 waves")
                        .font(AppTypography.caption.font)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .appCardStyle(.default)
            }
            .buttonStyle(.plain)
        }
        .appHorizontalPadding()
    }

    private var recommendedProductsSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            Text("Recommended For You")
                .font(AppTypography.headline.font)
                .appHorizontalPadding()

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: AppSpacing.md) {
                    ForEach(viewModel.recommendedProducts) { product in
                        Button {
                            coordinator.navigate(to: .product(productID: product.id))
                        } label: {
                            VStack(alignment: .leading, spacing: AppSpacing.xs) {
                                Image(systemName: product.imageURLString ?? "bag.fill")
                                    .font(.largeTitle)
                                    .frame(width: 80, height: 80)
                                    .foregroundStyle(AppColors.primary)
                                    .background(Color(.systemGray6))
                                    .cornerRadius(AppCornerRadius.medium)

                                Text(product.name)
                                    .font(AppTypography.caption.font)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.primary)
                                    .lineLimit(1)

                                Text("₹\(Int(product.price))")
                                    .font(AppTypography.body.font)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.primary)
                            }
                            .frame(width: 100)
                            .appCardStyle(.flat)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, AppSpacing.md)
            }
        }
    }

    private var trendingProductsSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            Text("Trending Near You")
                .font(AppTypography.headline.font)
                .appHorizontalPadding()

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: AppSpacing.md) {
                ForEach(viewModel.trendingProducts) { product in
                    Button {
                        coordinator.navigate(to: .product(productID: product.id))
                    } label: {
                        VStack(alignment: .leading, spacing: AppSpacing.sm) {
                            HStack {
                                Image(systemName: product.imageURLString ?? "bag.fill")
                                    .font(.title)
                                    .frame(width: 50, height: 50)
                                    .foregroundStyle(AppColors.primary)
                                Spacer()
                                Text("₹\(Int(product.price))")
                                    .font(AppTypography.body.font)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.primary)
                            }
                            Text(product.name)
                                .font(AppTypography.caption.font)
                                .fontWeight(.semibold)
                                .foregroundStyle(.primary)
                                .lineLimit(1)
                        }
                        .appCardStyle(.default)
                    }
                    .buttonStyle(.plain)
                }
            }
            .appHorizontalPadding()
        }
    }
}
