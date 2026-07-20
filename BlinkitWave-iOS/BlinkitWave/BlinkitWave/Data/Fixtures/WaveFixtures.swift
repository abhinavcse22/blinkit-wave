import Foundation

/// Static data fixtures for delivery wave clusters.
enum WaveFixtures {
    /// The complete list of exactly 10 deterministic waves (live and scheduled).
    static let all: [Wave] = {
        let activeOrders = OrderFixtures.all.filter { $0.status == .waveAssembling }
        var waves: [Wave] = []
        
        for i in 0..<10 {
            let indexString = String(format: "%02d", i + 1)
            let isLive = i < 5
            
            // Assign orders to waves deterministically
            var assignedOrders: [Order] = []
            if i < activeOrders.count {
                assignedOrders.append(activeOrders[i])
            }
            if (i + 1) < activeOrders.count {
                assignedOrders.append(activeOrders[i + 1])
            }
            
            let wave = Wave(
                id: "WAVE-FIX-\(indexString)",
                type: isLive ? .live : .scheduled,
                status: .assembling,
                orders: assignedOrders,
                creationDate: Date(timeIntervalSinceNow: -1200.0 * Double(i)),
                scheduledDispatchTime: Date(timeIntervalSinceNow: 1800.0),
                deliveryRadiusMeters: 500.0,
                centroidLatitude: 28.6273,
                centroidLongitude: 77.3725
            )
            
            // Link orders back to wave
            for order in assignedOrders {
                order.wave = wave
            }
            
            waves.append(wave)
        }
        
        return waves
    }()
}
