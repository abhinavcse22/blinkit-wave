import SwiftUI

/// Minimal stand-in view used until feature modules replace placeholders.
struct DestinationPlaceholderView: View {

    let title: String
    var subtitle: String?
    let systemImage: String

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: systemImage)
                .font(.system(size: 40))
                .foregroundStyle(.secondary)

            Text(title)
                .font(.title2.weight(.semibold))

            if let subtitle {
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
