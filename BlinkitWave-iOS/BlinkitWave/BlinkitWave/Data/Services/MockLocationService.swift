import Foundation

/// Stateless mock service managing geographical distance evaluations and neighbor clustering.
struct MockLocationService {
    private let radiusMatcher = RadiusMatcher(configuration: .defaultConfiguration)

    /// Finds candidate order baskets clustered within proximity distance rules.
    func findNearbyBaskets(center: Address, candidateOrders: [Order]) -> [Order] {
        radiusMatcher.findNearbyOrders(center: center, candidates: candidateOrders)
    }

    /// Computes direct distance metrics between two addresses in meters using Haversine equations.
    func calculateDistance(from: Address, to: Address) -> Double {
        let earthRadiusMeters = 6371000.0
        let dLat = (to.latitude - from.latitude) * .pi / 180.0
        let dLon = (to.longitude - from.longitude) * .pi / 180.0
        let a = sin(dLat/2) * sin(dLat/2) + cos(from.latitude * .pi / 180.0) * cos(to.latitude * .pi / 180.0) * sin(dLon/2) * sin(dLon/2)
        let c = 2 * atan2(sqrt(a), sqrt(1-a))
        return earthRadiusMeters * c
    }
}
