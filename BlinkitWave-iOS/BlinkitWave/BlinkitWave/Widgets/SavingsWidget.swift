import WidgetKit
import SwiftUI

/// Entry model for WidgetKit layouts.
struct SavingsEntry: TimelineEntry {
    let date: Date
    let totalSavings: Double
}

/// Dynamic widget entry view displaying total cash saved.
struct SavingsWidgetEntryView : View {
    var entry: SavingsEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text("🌊 WAVE SAVINGS")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.secondary)
                Spacer()
                Image(systemName: "leaf.fill")
                    .font(.caption2)
                    .foregroundColor(.green)
            }
            
            Spacer()
            
            Text("₹\(Int(entry.totalSavings))")
                .font(.system(size: 26, weight: .bold))
                .foregroundColor(.green)
            
            Text("Saved this week")
                .font(.system(size: 9, weight: .semibold))
                .foregroundColor(.secondary)
        }
        .padding()
        .containerBackground(for: .widget) {
            Color(.systemBackground)
        }
    }
}
