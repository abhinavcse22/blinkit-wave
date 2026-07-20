import Foundation

/// Stateless mock service simulating assembly progression updates and dispatch triggers.
struct MockWaveService {
    /// Injected business configurations.
    let configuration: EngineConfiguration

    init(configuration: EngineConfiguration = .defaultConfiguration) {
        self.configuration = configuration
    }

    /// Evaluates wave subtotal values to determine assembly states.
    func simulateWaveProgression(wave: Wave) -> Wave {
        let combinedSubtotal = wave.orders.reduce(0.0) { $0 + $1.subtotal }
        if combinedSubtotal >= configuration.freeDeliveryThreshold {
            wave.status = .confirmed
        } else {
            wave.status = .assembling
        }
        return wave
    }

    /// Determines if a wave should be dispatched based on the reference timeline.
    func evaluateWaveDispatch(wave: Wave, currentTime: Date) -> Wave {
        if currentTime >= wave.scheduledDispatchTime {
            wave.status = .dispatched
            wave.actualDispatchTime = currentTime
            
            // Cascade status changes down to associated orders
            for order in wave.orders {
                order.status = .dispatched
            }
        }
        return wave
    }
}
