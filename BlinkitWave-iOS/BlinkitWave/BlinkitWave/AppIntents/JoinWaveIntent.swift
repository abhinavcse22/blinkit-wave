import AppIntents

/// App Intent enabling Siri and Shortcuts integration to join active waves.
struct JoinWaveIntent: AppIntent {
    static var title: LocalizedStringResource = "Join Next Wave"
    static var description = IntentDescription("Clusters your pending order into the next neighborhood wave.")

    func perform() async throws -> some IntentResult & ReturnsValue<String> {
        // Return deterministic mock result matching our Sector 62 fixtures
        return .result(
            value: "WAVE-FIX-01",
            dialog: "Successfully matched and joined the active Sector 62 live wave! You saved ₹35."
        )
    }
}
