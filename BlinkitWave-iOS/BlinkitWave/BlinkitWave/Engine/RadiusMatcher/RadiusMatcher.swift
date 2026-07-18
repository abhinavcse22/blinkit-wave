import Foundation

/// Pure component responsible for proximity coordinates clustering and nearby order matching.
struct RadiusMatcher {
    /// Injected business configurations.
    let configuration: EngineConfiguration

    /// Filters candidate neighborhood orders that fall within the configured delivery radius.
    /// - Parameters:
    ///   - center: The physical address of the primary user checkout.
    ///   - candidates: Pool of active neighbor orders currently available.
    /// - Returns: Subset of orders within the maximum matched distance.
    func findNearbyOrders(center: Address, candidates: [Order]) -> [Order] {
        candidates.filter { order in
            let distance = distanceBetween(
                center.latitude, center.longitude,
                order.deliveryAddress.latitude, order.deliveryAddress.longitude
            )
            return distance <= configuration.deliveryRadiusMeters
        }
    }
    
    /// Computes distance in meters between two coordinates using the Haversine formula.
    private func distanceBetween(_ lat1: Double, _ lon1: Double, _ lat2: Double, _ lon2: Double) -> Double {
        let earthRadiusMeters = 6371000.0
        let dLat = (lat2 - lat1) * .pi / 180.0
        let dLon = (lon2 - lon1) * .pi / 180.0
        let a = sin(dLat/2) * sin(dLat/2) + cos(lat1 * .pi / 180.0) * cos(lat2 * .pi / 180.0) * sin(dLon/2) * sin(dLon/2)
        let c = 2 * atan2(sqrt(a), sqrt(1-a))
        return earthRadiusMeters * c
    }
}
