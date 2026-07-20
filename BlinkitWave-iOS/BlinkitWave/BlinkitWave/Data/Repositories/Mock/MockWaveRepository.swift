import Foundation

/// Concrete Mock implementation of WaveRepository.
final class MockWaveRepository: WaveRepository, @unchecked Sendable {
    private var waves: [Wave]

    init() {
        self.waves = WaveFixtures.all
    }

    func fetchActiveWaves() async throws -> [Wave] {
        waves
    }

    func fetchWave(byID id: String) async throws -> Wave? {
        waves.first { $0.id == id }
    }

    func createWave(_ wave: Wave) async throws -> Wave {
        waves.append(wave)
        return wave
    }

    func joinWave(order: Order, waveID: String) async throws -> Wave? {
        guard let index = waves.firstIndex(where: { $0.id == waveID }) else {
            throw RepositoryError.notFound(id: waveID)
        }
        let wave = waves[index]
        if !wave.orders.contains(where: { $0.id == order.id }) {
            wave.orders.append(order)
            order.wave = wave
        }
        return wave
    }

    func updateWaveStatus(waveID: String, status: WaveStatus) async throws -> Wave? {
        guard let index = waves.firstIndex(where: { $0.id == waveID }) else {
            throw RepositoryError.notFound(id: waveID)
        }
        waves[index].status = status
        
        for order in waves[index].orders {
            if status == .dispatched {
                order.status = .dispatched
            } else if status == .completed {
                order.status = .delivered
            }
        }
        return waves[index]
    }
}
