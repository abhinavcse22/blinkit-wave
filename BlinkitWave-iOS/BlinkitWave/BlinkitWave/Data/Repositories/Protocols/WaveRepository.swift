import Foundation

/// Repository protocol defining operations for batch delivery wave clusters.
protocol WaveRepository: Sendable {
    /// Retrieves all active waves in the neighborhood.
    func fetchActiveWaves() async throws -> [Wave]
    
    /// Retrieves a single wave by its ID.
    func fetchWave(byID id: String) async throws -> Wave?
    
    /// Creates and registers a new delivery wave cluster.
    func createWave(_ wave: Wave) async throws -> Wave
    
    /// Adds an order to a designated wave cluster.
    func joinWave(order: Order, waveID: String) async throws -> Wave?
    
    /// Updates the dispatch status of a wave cluster.
    func updateWaveStatus(waveID: String, status: WaveStatus) async throws -> Wave?
}
