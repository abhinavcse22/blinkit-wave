import Foundation

/// Static data fixtures for product categories.
enum CategoryFixtures {
    /// The complete list of exactly 10 deterministic categories.
    static let all: [Category] = [
        Category(id: "fruits", name: "Fresh Fruits", iconName: "apple.logo"),
        Category(id: "vegetables", name: "Fresh Vegetables", iconName: "leaf.fill"),
        Category(id: "dairy", name: "Dairy & Eggs", iconName: "drop.fill"),
        Category(id: "bakery", name: "Bakery & Bread", iconName: "birthday.cake.fill"),
        Category(id: "snacks", name: "Snacks & Munchies", iconName: "flame.fill"),
        Category(id: "beverages", name: "Beverages", iconName: "cup.and.saucer.fill"),
        Category(id: "personal_care", name: "Personal Care", iconName: "sparkles"),
        Category(id: "household", name: "Household Essentials", iconName: "house.fill"),
        Category(id: "baby_care", name: "Baby Care", iconName: "stroller.fill"),
        Category(id: "pet_care", name: "Pet Care", iconName: "pawprint.fill")
    ]
}
