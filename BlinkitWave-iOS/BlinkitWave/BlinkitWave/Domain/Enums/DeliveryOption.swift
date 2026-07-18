import Foundation

/// Represents the selected delivery type and optimization option chosen for checkout.
enum DeliveryOption: Codable, Sendable, Hashable {
    /// Instant fulfillment with an associated flat delivery fee.
    case instant(fee: Double)
    
    /// Joined a live wave pool with free or reduced delivery cost.
    case liveWave(waveID: String)
    
    /// Scheduled in a predicted high-density wave slot with free or reduced delivery.
    case scheduledWave(slotID: String)
    
    /// Deposited minimum threshold in the Smart Wallet to unlock free delivery, placing the remainder in wallet credits.
    case smartWallet

    enum CodingKeys: String, CodingKey {
        case type
        case fee
        case waveID
        case slotID
    }

    enum OptionType: String, Codable {
        case instant
        case liveWave
        case scheduledWave
        case smartWallet
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(OptionType.self, forKey: .type)
        switch type {
        case .instant:
            let fee = try container.decode(Double.self, forKey: .fee)
            self = .instant(fee: fee)
        case .liveWave:
            let waveID = try container.decode(String.self, forKey: .waveID)
            self = .liveWave(waveID: waveID)
        case .scheduledWave:
            let slotID = try container.decode(String.self, forKey: .slotID)
            self = .scheduledWave(slotID: slotID)
        case .smartWallet:
            self = .smartWallet
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .instant(let fee):
            try container.encode(OptionType.instant, forKey: .type)
            try container.encode(fee, forKey: .fee)
        case .liveWave(let waveID):
            try container.encode(OptionType.liveWave, forKey: .type)
            try container.encode(waveID, forKey: .waveID)
        case .scheduledWave(let slotID):
            try container.encode(OptionType.scheduledWave, forKey: .type)
            try container.encode(slotID, forKey: .slotID)
        case .smartWallet:
            try container.encode(OptionType.smartWallet, forKey: .type)
        }
    }
}
