import Foundation

/// Static data fixtures for user profiles.
enum UserFixtures {
    /// The complete list of exactly 10 deterministic users clustered around Sector 62, Noida.
    static let all: [User] = {
        let names = [
            "Abhinav Gupta", "Priya Sharma", "Rohan Das", "Sneha Reddy", "Amit Patel",
            "Vikram Malhotra", "Neha Joshi", "Rahul Verma", "Divya Nair", "Manoj Kumar"
        ]
        
        let coords = [
            (28.6273, 77.3725), // Abhinav
            (28.6280, 77.3730), // Priya
            (28.6265, 77.3718), // Rohan
            (28.6290, 77.3745), // Sneha
            (28.6250, 77.3700), // Amit
            (28.6270, 77.3710), // Vikram
            (28.6285, 77.3735), // Neha
            (28.6260, 77.3720), // Rahul
            (28.6278, 77.3728), // Divya
            (28.6268, 77.3715)  // Manoj
        ]

        var users: [User] = []
        
        for i in 0..<10 {
            let indexString = String(format: "%02d", i + 1)
            let userUUID = UUID(uuidString: "10000000-0000-0000-0000-0000000000\(indexString)")!
            let walletUUID = UUID(uuidString: "20000000-0000-0000-0000-0000000000\(indexString)")!
            let savingsUUID = UUID(uuidString: "30000000-0000-0000-0000-0000000000\(indexString)")!
            let addressUUID = UUID(uuidString: "40000000-0000-0000-0000-0000000000\(indexString)")!
            
            let name = names[i]
            let nameComponents = name.split(separator: " ")
            let firstName = nameComponents.first?.lowercased() ?? "user"
            
            let address = Address(
                id: addressUUID,
                label: "Home",
                streetAddress: "Apartment No. \(100 + i * 10), Sector 62",
                apartmentSuite: "Sector 62",
                city: "Noida",
                state: "Uttar Pradesh",
                postalCode: "201301",
                country: "India",
                latitude: coords[i].0,
                longitude: coords[i].1
            )
            
            let user = User(
                id: userUUID,
                name: name,
                email: "\(firstName)@blinkitwave.com",
                phoneNumber: "+91 99999000\(indexString)",
                addresses: [address]
            )
            
            let wallet = Wallet(
                id: walletUUID,
                balance: Double(100 + i * 50)
            )
            user.wallet = wallet
            
            let savings = Savings(
                id: savingsUUID,
                totalSavingsAmount: Double(i * 35),
                wavesJoinedCount: i,
                lastSavedDate: Date(timeIntervalSinceNow: -86400 * Double(i))
            )
            user.savings = savings
            
            users.append(user)
        }
        
        return users
    }()
    
    /// The default main test user profile.
    static var defaultUser: User {
        all[0]
    }
}
