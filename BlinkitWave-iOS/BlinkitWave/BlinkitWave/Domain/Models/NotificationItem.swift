import Foundation
import SwiftData

/// Logs incoming in-app and push notifications for user review.
@Model
final class NotificationItem: Codable, Identifiable {
    /// Unique identifier for the notification record.
    @Attribute(.unique) var id: UUID
    
    /// Header title text of the notification.
    var title: String
    
    /// Description content body of the notification.
    var bodyContent: String
    
    /// Exact timestamp when the notification was received.
    var receivedDate: Date
    
    /// Checkmark identifying whether the user opened the notification.
    var isRead: Bool
    
    /// Optional navigable screen destination linked to the message.
    var associatedDestination: AppDestination?

    init(
        id: UUID = UUID(),
        title: String,
        bodyContent: String,
        receivedDate: Date = Date(),
        isRead: Bool = false,
        associatedDestination: AppDestination? = nil
    ) {
        self.id = id
        self.title = title
        self.bodyContent = bodyContent
        self.receivedDate = receivedDate
        self.isRead = isRead
        self.associatedDestination = associatedDestination
    }

    // MARK: - Codable Conformance

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case bodyContent
        case receivedDate
        case isRead
        case associatedDestination
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.bodyContent = try container.decode(String.self, forKey: .bodyContent)
        self.receivedDate = try container.decode(Date.self, forKey: .receivedDate)
        self.isRead = try container.decode(Bool.self, forKey: .isRead)
        self.associatedDestination = try container.decodeIfPresent(AppDestination.self, forKey: .associatedDestination)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(bodyContent, forKey: .bodyContent)
        try container.encode(receivedDate, forKey: .receivedDate)
        try container.encode(isRead, forKey: .isRead)
        try container.encode(associatedDestination, forKey: .associatedDestination)
    }
}
