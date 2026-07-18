import Foundation
import SwiftData

/// Represents a batch delivery wave grouping multiple customer orders together.
@Model
final class Wave: Codable, Identifiable {
    /// Unique identifier for the Wave (e.g. "WAVE-12345").
    @Attribute(.unique) var id: String
    
    /// The wave classification category (live vs scheduled slot).
    var type: WaveType
    
    /// Current assembly or delivery state of the wave batch.
    var status: WaveStatus
    
    /// The orders aggregated within this delivery wave.
    @Relationship(deleteRule: .nullify, inverse: \Order.wave)
    var orders: [Order] = []
    
    /// Timestamp when this wave was initialized.
    var creationDate: Date
    
    /// Predicted or scheduled departure time of the wave rider.
    var scheduledDispatchTime: Date
    
    /// The exact timestamp when dispatch happened.
    var actualDispatchTime: Date?
    
    /// Configured neighborhood boundary limits in meters.
    var deliveryRadiusMeters: Double
    
    /// Midpoint latitude coordinate of the delivery cluster.
    var centroidLatitude: Double
    
    /// Midpoint longitude coordinate of the delivery cluster.
    var centroidLongitude: Double

    /// Aggregated value of all orders joined in the wave.
    var totalValue: Double {
        orders.reduce(0.0) { $0 + $1.subtotal }
    }

    /// Verifies if the aggregated order value meets the ₹150 threshold to qualify for free delivery.
    var isThresholdMet: Bool {
        totalValue >= 150.0
    }

    init(
        id: String,
        type: WaveType,
        status: WaveStatus = .assembling,
        orders: [Order] = [],
        creationDate: Date = Date(),
        scheduledDispatchTime: Date,
        actualDispatchTime: Date? = nil,
        deliveryRadiusMeters: Double = 500.0,
        centroidLatitude: Double,
        centroidLongitude: Double
    ) {
        self.id = id
        self.type = type
        self.status = status
        self.orders = orders
        self.creationDate = creationDate
        self.scheduledDispatchTime = scheduledDispatchTime
        self.actualDispatchTime = actualDispatchTime
        self.deliveryRadiusMeters = deliveryRadiusMeters
        self.centroidLatitude = centroidLatitude
        self.centroidLongitude = centroidLongitude
    }

    // MARK: - Codable Conformance

    enum CodingKeys: String, CodingKey {
        case id
        case type
        case status
        case orders
        case creationDate
        case scheduledDispatchTime
        case actualDispatchTime
        case deliveryRadiusMeters
        case centroidLatitude
        case centroidLongitude
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.type = try container.decode(WaveType.self, forKey: .type)
        self.status = try container.decode(WaveStatus.self, forKey: .status)
        self.orders = try container.decode([Order].self, forKey: .orders)
        self.creationDate = try container.decode(Date.self, forKey: .creationDate)
        self.scheduledDispatchTime = try container.decode(Date.self, forKey: .scheduledDispatchTime)
        self.actualDispatchTime = try container.decodeIfPresent(Date.self, forKey: .actualDispatchTime)
        self.deliveryRadiusMeters = try container.decode(Double.self, forKey: .deliveryRadiusMeters)
        self.centroidLatitude = try container.decode(Double.self, forKey: .centroidLatitude)
        self.centroidLongitude = try container.decode(Double.self, forKey: .centroidLongitude)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(type, forKey: .type)
        try container.encode(status, forKey: .status)
        try container.encode(orders, forKey: .orders)
        try container.encode(creationDate, forKey: .creationDate)
        try container.encode(scheduledDispatchTime, forKey: .scheduledDispatchTime)
        try container.encode(actualDispatchTime, forKey: .actualDispatchTime)
        try container.encode(deliveryRadiusMeters, forKey: .deliveryRadiusMeters)
        try container.encode(centroidLatitude, forKey: .centroidLatitude)
        try container.encode(centroidLongitude, forKey: .centroidLongitude)
    }
}
