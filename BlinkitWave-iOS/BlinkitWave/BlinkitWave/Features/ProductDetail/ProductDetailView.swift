import SwiftUI

/// Premium, high-fidelity Product Detail Screen for Blinkit Wave.
struct ProductDetailView: View {
    let productID: String
    
    @State private var viewModel = ProductDetailViewModel()
    @Environment(NavigationCoordinator.self) private var coordinator

    var body: some View {
        VStack(spacing: 0) {
            if viewModel.isLoading {
                ProgressView("Loading product...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let product = viewModel.product {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: AppSpacing.lg) {
                        // Product Image Section
                        ImageContainer(imageName: product.imageURLString ?? "bag.fill")
                        
                        // Main info
                        VStack(alignment: .leading, spacing: AppSpacing.sm) {
                            HStack {
                                Text(product.category?.name.uppercased() ?? "GROCERY")
                                    .font(AppTypography.caption.font)
                                    .fontWeight(.bold)
                                    .foregroundStyle(AppColors.primary)
                                
                                Spacer()
                                
                                Text(product.isStockAvailable ? "In Stock" : "Out of Stock")
                                    .font(AppTypography.caption.font)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(product.isStockAvailable ? AppColors.success : AppColors.error)
                            }
                            
                            Text(product.name)
                                .font(AppTypography.largeTitle.font)
                                .fontWeight(.bold)
                            
                            Text(product.unitDescription)
                                .font(AppTypography.body.font)
                                .foregroundStyle(.secondary)
                        }
                        .appHorizontalPadding()
                        
                        // Price section
                        HStack {
                            VStack(alignment: .leading, spacing: AppSpacing.xs) {
                                Text("Price")
                                    .font(AppTypography.caption.font)
                                    .foregroundStyle(.secondary)
                                Text("₹\(Int(product.price))")
                                    .font(AppTypography.largeTitle.font)
                                    .fontWeight(.bold)
                            }
                            Spacer()
                            
                            // Quantity controller
                            HStack(spacing: AppSpacing.md) {
                                Button {
                                    if viewModel.quantity > 1 { viewModel.quantity -= 1 }
                                } label: {
                                    Image(systemName: "minus.circle.fill")
                                        .font(.title2)
                                        .foregroundStyle(AppColors.primary)
                                }
                                
                                Text("\(viewModel.quantity)")
                                    .font(AppTypography.title.font)
                                    .fontWeight(.bold)
                                    .frame(width: 30)
                                
                                Button {
                                    viewModel.quantity += 1
                                } label: {
                                    Image(systemName: "plus.circle.fill")
                                        .font(.title2)
                                        .foregroundStyle(AppColors.primary)
                                }
                            }
                            .padding(.horizontal, AppSpacing.sm)
                            .padding(.vertical, AppSpacing.xs)
                            .background(Color(.systemGray6))
                            .cornerRadius(AppCornerRadius.medium)
                        }
                        .appHorizontalPadding()
                        
                        Divider()
                            .padding(.horizontal, AppSpacing.md)
                        
                        // Description
                        VStack(alignment: .leading, spacing: AppSpacing.sm) {
                            Text("Product Description")
                                .font(AppTypography.headline.font)
                            Text(product.productDescription)
                                .font(AppTypography.body.font)
                                .foregroundStyle(.secondary)
                                .lineSpacing(4)
                        }
                        .appHorizontalPadding()
                    }
                }
                
                // Add to Cart bar
                addToCartBar
            } else {
                Text("Product details could not be found.")
                    .font(AppTypography.body.font)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .appBackground()
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadProduct(byID: productID)
        }
    }

    private var addToCartBar: some View {
        VStack {
            Button {
                Task {
                    await viewModel.addToCart()
                }
            } label: {
                HStack {
                    Image(systemName: viewModel.isAdded ? "checkmark.circle.fill" : "cart.fill.badge.plus")
                    Text(viewModel.isAdded ? "Added to Cart" : "Add to Cart")
                }
                .font(AppTypography.button.font)
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(.appPrimary)
            .disabled(!(viewModel.product?.isStockAvailable ?? false))
        }
        .padding(AppSpacing.md)
        .appGlassEffect()
    }
}

private struct ImageContainer: View {
    let imageName: String
    
    var body: some View {
        VStack {
            Image(systemName: imageName)
                .font(.system(size: 80))
                .foregroundStyle(AppColors.primary)
                .frame(height: 250)
                .frame(maxWidth: .infinity)
                .background(
                    LinearGradient(
                        colors: [AppColors.primary.opacity(0.05), .clear],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
        }
    }
}
