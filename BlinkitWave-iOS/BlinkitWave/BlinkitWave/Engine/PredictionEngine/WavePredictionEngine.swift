import Foundation

/// Pure component simulating AI slot density predictions based on locality codes and date constraints.
struct WavePredictionEngine {
    /// Injected business configurations.
    let configuration: EngineConfiguration

    /// Forecasts the next slot metrics for a designated time of day and locality.
    /// - Parameters:
    ///   - currentTime: The reference time at evaluation.
    ///   - postalCode: The locality identification code.
    /// - Returns: A calculated WaveSlot prediction.
    func predictNextSlot(currentTime: Date, postalCode: String) -> WaveSlot {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: currentTime)
        
        // Slot starts 30 minutes in the future, lasting 1 hour.
        let startOfSlot = calendar.date(byAdding: .minute, value: 30, to: currentTime) ?? currentTime
        let endOfSlot = calendar.date(byAdding: .hour, value: 1, to: startOfSlot) ?? startOfSlot
        
        // Define peak hours in India (Lunch rush: 12 PM - 3 PM, Dinner rush: 6 PM - 9 PM)
        let isPeak = (hour >= 12 && hour <= 15) || (hour >= 18 && hour <= 21)
        
        // Compute a process-stable seed hash value to ensure identical results across restarts.
        let seedString = "\(postalCode)-\(hour)"
        let seedHash = stableHash(seedString)
        
        let predictedCount = isPeak ? (15 + (seedHash % 15)) : (2 + (seedHash % 7))
        let confidence: PredictionConfidence = isPeak ? .high : (predictedCount >= 5 ? .medium : .low)
        let discount = isPeak ? configuration.standardDeliveryFee : 0.0
        
        return WaveSlot(
            id: "SLOT-\(postalCode)-\(hour)-\(seedHash % 1000)",
            startTime: startOfSlot,
            endTime: endOfSlot,
            predictedOrderCount: predictedCount,
            predictedConfidence: confidence,
            estimatedDeliveryDiscount: discount
        )
    }
    
    /// Returns a process-independent stable hash code for deterministic values.
    private func stableHash(_ string: String) -> Int {
        string.utf8.reduce(0) { $0 + Int($1) }
    }
}
