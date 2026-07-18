import Foundation

/// Models a customer's physical delivery address, including coordinates for neighborhood clustering.
struct Address: Codable, Sendable, Identifiable, Hashable {
    /// Unique identifier for the address.
    var id: UUID
    
    /// User-defined label (e.g. "Home", "Office", "Gym").
    var label: String
    
    /// Main street level details.
    var streetAddress: String
    
    /// Optional apartment, suite, or flat identifiers.
    var apartmentSuite: String?
    
    /// Locality city.
    var city: String
    
    /// Locality state.
    var state: String
    
    /// Zip/postal identification code.
    var postalCode: String
    
    /// Shipping country.
    var country: String
    
    /// Geographical latitude coordinates for proximity matching.
    var latitude: Double
    
    /// Geographical longitude coordinates for proximity matching.
    var longitude: Double

    init(
        id: UUID = UUID(),
        label: String,
        streetAddress: String,
        apartmentSuite: String? = nil,
        city: String,
        state: String,
        postalCode: String,
        country: String,
        latitude: Double,
        longitude: Double
    ) {
        self.id = id
        self.label = label
        self.streetAddress = streetAddress
        self.apartmentSuite = apartmentSuite
        self.city = city
        self.state = state
        self.postalCode = postalCode
        self.country = country
        self.latitude = latitude
        self.longitude = longitude
    }
}
