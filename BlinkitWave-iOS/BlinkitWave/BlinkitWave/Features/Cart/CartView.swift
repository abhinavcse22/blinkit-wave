import SwiftUI

/// Premium, high-fidelity Shopping Cart Screen for Blinkit Wave.
struct CartView: View {
    @State private var viewModel = CartViewModel()
    @Environment(NavigationCoordinator.self) private var coordinator

    var body: some View {
        VStack(spacing: 0) {
            if viewModel.isLoading {
                ProgressView("Loading cart...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let cart = viewModel.cart, !cart.items.isEmpty {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: AppSpacing.lg) {
                        // Free Delivery Progress Meter
                        freeDeliveryProgressMeter(subtotal: cartSubtotal(cart))
                        
                        // List of items in the cart
                        itemsList(cart: cart)
                    }
                    .padding(.top, AppSpacing.md)
                }
                
                // Billed checkout summary
                checkoutBar(cart: cart)
            } else {
                emptyCartView
            }
        }
        .appBackground()
        .navigationTitle("My Cart")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if let cart = viewModel.cart, !cart.items.isEmpty {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(role: .destructive) {
                        Task {
                            await viewModel.clearCart()
                        }
                    } label: {
                        Text("Clear")
                            .font(AppTypography.caption.font)
                            .foregroundStyle(AppColors.error)
                    }
                }
            }
        }
        .task {
            await viewModel.loadCart()
        }
    }

    // MARK: - Subviews

    private func freeDeliveryProgressMeter(subtotal: Double) -> some View {
        VStack(alignment: .leading, spacing: AppSpacing.xs) {
            let threshold = viewModel.freeDeliveryThreshold
            let difference = max(0.0, threshold - subtotal)
            
            HStack {
                Image(systemName: subtotal >= threshold ? "checkmark.circle.fill" : "sparkles")
                    .foregroundStyle(subtotal >= threshold ? AppColors.success : AppColors.primary)
                Text(subtotal >= threshold ? "Free Delivery Unlocked!" : "Add ₹\(Int(difference)) more for FREE Delivery")
                    .font(AppTypography.caption.font)
                    .fontWeight(.semibold)
            }
            
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color(.systemGray5))
                        .frame(height: 6)
                    Capsule()
                        .fill(subtotal >= threshold ? AppColors.success : AppColors.primary)
                        .frame(width: geo.size.width * CGFloat(viewModel.freeDeliveryProgress), height: 6)
                }
            }
            .frame(height: 6)
        }
        .appCardStyle(.default)
        .appHorizontalPadding()
    }

    private func itemsList(cart: Cart) -> some View {
        VStack(spacing: 0) {
            ForEach(cart.items) { item in
                if let product = item.product {
                    HStack(spacing: AppSpacing.md) {
                        Image(systemName: product.imageURLString ?? "bag.fill")
                            .font(.title2)
                            .frame(width: 50, height: 50)
                            .foregroundStyle(AppColors.primary)
                            .background(Color(.systemGray6))
                            .cornerRadius(AppCornerRadius.medium)
                        
                        VStack(alignment: .leading, spacing: AppSpacing.xs) {
                            Text(product.name)
                                .font(AppTypography.caption.font)
                                .fontWeight(.semibold)
                                .lineLimit(1)
                            Text(product.unitDescription)
                                .font(AppTypography.caption.font)
                                .foregroundStyle(.secondary)
                            Text("₹\(Int(product.price * Double(item.quantity)))")
                                .font(AppTypography.body.font)
                                .fontWeight(.bold)
                        }
                        
                        Spacer()
                        
                        // +/- Quantity Controls
                        HStack(spacing: AppSpacing.sm) {
                            Button {
                                Task { await viewModel.updateQuantity(for: item, delta: -1) }
                            } label: {
                                Image(systemName: "minus.square.fill")
                                    .font(.title2)
                                    .foregroundStyle(.secondary)
                            }
                            
                            Text("\(item.quantity)")
                                .font(AppTypography.body.font)
                                .fontWeight(.bold)
                                .frame(width: 25)
                            
                            Button {
                                Task { await viewModel.updateQuantity(for: item, delta: 1) }
                            } label: {
                                Image(systemName: "plus.square.fill")
                                    .font(.title2)
                                    .foregroundStyle(AppColors.primary)
                            }
                        }
                    }
                    .padding(.vertical, AppSpacing.sm)
                    
                    if item.id != cart.items.last?.id {
                        Divider()
                    }
                }
            }
        }
        .appCardStyle(.flat)
        .appHorizontalPadding()
    }

    private func checkoutBar(cart: Cart) -> some View {
        VStack(spacing: AppSpacing.md) {
            let subtotal = cartSubtotal(cart)
            HStack {
                VStack(alignment: .leading, spacing: AppSpacing.xs) {
                    Text("Total Amount")
                        .font(AppTypography.caption.font)
                        .foregroundStyle(.secondary)
                    Text("₹\(Int(subtotal))")
                        .font(AppTypography.title.font)
                        .fontWeight(.bold)
                }
                Spacer()
                
                Button {
                    coordinator.navigate(to: .waveRecommendation)
                } label: {
                    HStack {
                        Text("Choose Delivery Option")
                        Image(systemName: "arrow.right.circle.fill")
                    }
                    .font(AppTypography.button.font)
                }
                .buttonStyle(.appPrimary)
            }
        }
        .padding(AppSpacing.md)
        .appGlassEffect()
    }

    private var emptyCartView: some View {
        VStack(spacing: AppSpacing.md) {
            Image(systemName: "cart")
                .font(.system(size: 60))
                .foregroundStyle(.secondary)
            Text("Your cart is empty")
                .font(AppTypography.headline.font)
            Text("Add fresh items from our catalog to get started.")
                .font(AppTypography.caption.font)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, AppSpacing.xl)
            
            Button {
                coordinator.selectTab(.home)
            } label: {
                Text("Start Shopping")
                    .font(AppTypography.button.font)
            }
            .buttonStyle(.appOutlined)
            .padding(.top, AppSpacing.sm)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    // MARK: - Helper calculations to keep business logic out of models
    private func cartSubtotal(_ cart: Cart) -> Double {
        cart.items.reduce(0.0) { sum, item in
            guard let product = item.product else { return sum }
            return sum + (product.price * Double(item.quantity))
        }
    }
}
