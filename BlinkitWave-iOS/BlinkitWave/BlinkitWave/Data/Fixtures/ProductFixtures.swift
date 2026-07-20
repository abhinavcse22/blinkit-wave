import Foundation

/// Static data fixtures for catalog products.
enum ProductFixtures {
    /// The complete list of exactly 100 deterministic products (10 per category).
    static let all: [Product] = {
        let cats = CategoryFixtures.all
        let fruits = cats.first { $0.id == "fruits" }
        let vegetables = cats.first { $0.id == "vegetables" }
        let dairy = cats.first { $0.id == "dairy" }
        let bakery = cats.first { $0.id == "bakery" }
        let snacks = cats.first { $0.id == "snacks" }
        let beverages = cats.first { $0.id == "beverages" }
        let personalCare = cats.first { $0.id == "personal_care" }
        let household = cats.first { $0.id == "household" }
        let babyCare = cats.first { $0.id == "baby_care" }
        let petCare = cats.first { $0.id == "pet_care" }

        return [
            // Fresh Fruits (10 items)
            Product(id: "SKU-FRT-001", name: "Red Apple", productDescription: "Sweet, crispy apples.", price: 180.0, imageURLString: "apple.logo", unitDescription: "4 pcs (600g)", category: fruits),
            Product(id: "SKU-FRT-002", name: "Banana Robusta", productDescription: "Fresh rich bananas.", price: 60.0, imageURLString: "leaf.fill", unitDescription: "6 pcs (800g)", category: fruits),
            Product(id: "SKU-FRT-003", name: "Nagpur Orange", productDescription: "Citrus sweet oranges.", price: 120.0, imageURLString: "sun.max.fill", unitDescription: "6 pcs (1kg)", category: fruits),
            Product(id: "SKU-FRT-004", name: "Strawberry Pack", productDescription: "Sweet red strawberries.", price: 150.0, imageURLString: "heart.fill", unitDescription: "200g", category: fruits),
            Product(id: "SKU-FRT-005", name: "Blueberry Tray", productDescription: "Antioxidant rich berries.", price: 299.0, imageURLString: "circle.grid.3x3.fill", unitDescription: "125g", category: fruits),
            Product(id: "SKU-FRT-006", name: "Green Grapes", productDescription: "Sweet seedless grapes.", price: 90.0, imageURLString: "bubbles.and.sparkles.fill", unitDescription: "500g", category: fruits),
            Product(id: "SKU-FRT-007", name: "Alphonso Mango", productDescription: "King of mangoes.", price: 450.0, imageURLString: "crown.fill", unitDescription: "2 pcs (500g)", category: fruits),
            Product(id: "SKU-FRT-008", name: "Watermelon", productDescription: "Sweet hydrating fruit.", price: 80.0, imageURLString: "globe", unitDescription: "1 pc (2kg)", category: fruits),
            Product(id: "SKU-FRT-009", name: "Peeled Pineapple", productDescription: "Tangy sweet chunks.", price: 110.0, imageURLString: "flame.fill", unitDescription: "800g", category: fruits),
            Product(id: "SKU-FRT-010", name: "Papaya", productDescription: "Rich in vitamin A.", price: 70.0, imageURLString: "leaf.fill", unitDescription: "1 pc (1kg)", category: fruits),

            // Fresh Vegetables (10 items)
            Product(id: "SKU-VEG-001", name: "Potato (Aloo)", productDescription: "Fresh local potatoes.", price: 35.0, imageURLString: "circle.fill", unitDescription: "1kg", category: vegetables),
            Product(id: "SKU-VEG-002", name: "Tomato (Tamatar)", productDescription: "Red salad tomatoes.", price: 45.0, imageURLString: "circle.fill", unitDescription: "500g", category: vegetables),
            Product(id: "SKU-VEG-003", name: "Onion (Pyaj)", productDescription: "Crisp red onions.", price: 40.0, imageURLString: "circle.fill", unitDescription: "1kg", category: vegetables),
            Product(id: "SKU-VEG-004", name: "Garlic (Lahsun)", productDescription: "Strong aromatic garlic.", price: 60.0, imageURLString: "staroflife.fill", unitDescription: "100g", category: vegetables),
            Product(id: "SKU-VEG-005", name: "Ginger (Adrak)", productDescription: "Spicy fresh ginger.", price: 50.0, imageURLString: "bolt.fill", unitDescription: "250g", category: vegetables),
            Product(id: "SKU-VEG-006", name: "Spinach (Palak)", productDescription: "Clean green spinach.", price: 25.0, imageURLString: "leaf.fill", unitDescription: "250g", category: vegetables),
            Product(id: "SKU-VEG-007", name: "Cauliflower (Gobhi)", productDescription: "Fresh cauliflower heads.", price: 55.0, imageURLString: "circle.hexagongrid.fill", unitDescription: "600g", category: vegetables),
            Product(id: "SKU-VEG-008", name: "Broccoli", productDescription: "Exotic green crowns.", price: 80.0, imageURLString: "leaf.fill", unitDescription: "300g", category: vegetables),
            Product(id: "SKU-VEG-009", name: "Carrot (Gajar)", productDescription: "Sweet orange carrots.", price: 40.0, imageURLString: "pencil", unitDescription: "500g", category: vegetables),
            Product(id: "SKU-VEG-010", name: "Cucumber (Kheera)", productDescription: "Cool salad cucumbers.", price: 30.0, imageURLString: "capsule.fill", unitDescription: "500g", category: vegetables),

            // Dairy & Eggs (10 items)
            Product(id: "SKU-DRY-001", name: "Full Cream Milk", productDescription: "Rich pasteurized milk.", price: 33.0, imageURLString: "drop.fill", unitDescription: "500 ml", category: dairy),
            Product(id: "SKU-DRY-002", name: "Toned Milk", productDescription: "Fresh toned milk.", price: 27.0, imageURLString: "drop.fill", unitDescription: "500 ml", category: dairy),
            Product(id: "SKU-DRY-003", name: "Salted Butter", productDescription: "Creamy table butter.", price: 58.0, imageURLString: "square.fill", unitDescription: "100g", category: dairy),
            Product(id: "SKU-DRY-004", name: "Fresh Paneer", productDescription: "Soft cottage cheese.", price: 90.0, imageURLString: "square.grid.2x2.fill", unitDescription: "200g", category: dairy),
            Product(id: "SKU-DRY-005", name: "Cheese Slices", productDescription: "Sandwich cheese slices.", price: 150.0, imageURLString: "square.stack.fill", unitDescription: "200g", category: dairy),
            Product(id: "SKU-DRY-006", name: "Cheese Cubes", productDescription: "Processed cheese cubes.", price: 130.0, imageURLString: "square.grid.3x3.fill", unitDescription: "200g", category: dairy),
            Product(id: "SKU-DRY-007", name: "Strawberry Yogurt", productDescription: "Flavored greek yogurt.", price: 45.0, imageURLString: "cup.and.saucer.fill", unitDescription: "90g", category: dairy),
            Product(id: "SKU-DRY-008", name: "Fresh Curd (Dahi)", productDescription: "Thick set curd.", price: 35.0, imageURLString: "cylinder.fill", unitDescription: "400g", category: dairy),
            Product(id: "SKU-DRY-009", name: "Fresh Cream", productDescription: "Thick kitchen cream.", price: 67.0, imageURLString: "drop.fill", unitDescription: "250 ml", category: dairy),
            Product(id: "SKU-DRY-010", name: "Table Eggs White", productDescription: "Farm fresh white eggs.", price: 45.0, imageURLString: "circle.grid.3x3.fill", unitDescription: "6 pcs", category: dairy),

            // Bakery & Bread (10 items)
            Product(id: "SKU-BAK-001", name: "White Bread", productDescription: "Soft sliced white bread.", price: 35.0, imageURLString: "square.fill", unitDescription: "400g", category: bakery),
            Product(id: "SKU-BAK-002", name: "Brown Bread", productDescription: "Whole wheat brown bread.", price: 45.0, imageURLString: "square.fill", unitDescription: "400g", category: bakery),
            Product(id: "SKU-BAK-003", name: "Multigrain Bread", productDescription: "Grain loaded bread loaf.", price: 55.0, imageURLString: "square.fill", unitDescription: "400g", category: bakery),
            Product(id: "SKU-BAK-004", name: "Garlic Bread Loaf", productDescription: "Garlic butter stuffed loaf.", price: 70.0, imageURLString: "capsule.fill", unitDescription: "250g", category: bakery),
            Product(id: "SKU-BAK-005", name: "Chocolate Croissant", productDescription: "Flaky chocolate pastry.", price: 99.0, imageURLString: "heart.fill", unitDescription: "1 pc", category: bakery),
            Product(id: "SKU-BAK-006", name: "Chocolate Muffin", productDescription: "Cocoa muffin with chips.", price: 60.0, imageURLString: "circle.fill", unitDescription: "1 pc", category: bakery),
            Product(id: "SKU-BAK-007", name: "Choco Chip Cookies", productDescription: "Baked crunchy cookies.", price: 120.0, imageURLString: "circle.grid.3x3.fill", unitDescription: "150g", category: bakery),
            Product(id: "SKU-BAK-008", name: "Burger Buns", productDescription: "Soft bakery burger buns.", price: 40.0, imageURLString: "circle.fill", unitDescription: "4 buns", category: bakery),
            Product(id: "SKU-BAK-009", name: "Pizza Base", productDescription: "Bake at home pizza base.", price: 45.0, imageURLString: "circle.fill", unitDescription: "2 pcs", category: bakery),
            Product(id: "SKU-BAK-010", name: "Tortilla Wraps", productDescription: "Flour wrap tortillas.", price: 160.0, imageURLString: "globe", unitDescription: "6 wraps", category: bakery),

            // Snacks & Munchies (10 items)
            Product(id: "SKU-SNC-001", name: "Potato Chips Salted", productDescription: "Salted crispy chips.", price: 20.0, imageURLString: "flame.fill", unitDescription: "50g", category: snacks),
            Product(id: "SKU-SNC-002", name: "Potato Chips Spicy", productDescription: "Chili flavored chips.", price: 20.0, imageURLString: "flame.fill", unitDescription: "50g", category: snacks),
            Product(id: "SKU-SNC-003", name: "Cheese Nachos", productDescription: "Triangular corn chips.", price: 50.0, imageURLString: "triangle.fill", unitDescription: "70g", category: snacks),
            Product(id: "SKU-SNC-004", name: "Butter Popcorn", productDescription: "Microwave butter popcorn.", price: 45.0, imageURLString: "staroflife.fill", unitDescription: "150g", category: snacks),
            Product(id: "SKU-SNC-005", name: "Salted Cashews", productDescription: "Roasted salted cashews.", price: 299.0, imageURLString: "capsule.fill", unitDescription: "200g", category: snacks),
            Product(id: "SKU-SNC-006", name: "Roasted Almonds", productDescription: "Crunchy californian almonds.", price: 249.0, imageURLString: "capsule.fill", unitDescription: "200g", category: snacks),
            Product(id: "SKU-SNC-007", name: "Salted Peanuts", productDescription: "Table salted peanuts.", price: 40.0, imageURLString: "capsule.fill", unitDescription: "200g", category: snacks),
            Product(id: "SKU-SNC-008", name: "Dairy Milk Chocolate", productDescription: "Rich milk chocolate.", price: 80.0, imageURLString: "square.fill", unitDescription: "60g", category: snacks),
            Product(id: "SKU-SNC-009", name: "Gummy Bears", productDescription: "Chewy fruit gummies.", price: 99.0, imageURLString: "circle.grid.2x2.fill", unitDescription: "80g", category: snacks),
            Product(id: "SKU-SNC-010", name: "Mini Pretzels", productDescription: "Baked salted pretzels.", price: 180.0, imageURLString: "heart.fill", unitDescription: "150g", category: snacks),

            // Beverages (10 items)
            Product(id: "SKU-BEV-001", name: "Cola Can", productDescription: "Classic carbonated soda.", price: 40.0, imageURLString: "cup.and.saucer.fill", unitDescription: "250 ml", category: beverages),
            Product(id: "SKU-BEV-002", name: "Sprite Can", productDescription: "Lemon flavored soda.", price: 40.0, imageURLString: "cup.and.saucer.fill", unitDescription: "250 ml", category: beverages),
            Product(id: "SKU-BEV-003", name: "Orange Fanta Can", productDescription: "Vibrant orange soda.", price: 40.0, imageURLString: "cup.and.saucer.fill", unitDescription: "250 ml", category: beverages),
            Product(id: "SKU-BEV-004", name: "Orange Juice", productDescription: "100% sweet orange juice.", price: 110.0, imageURLString: "drop.fill", unitDescription: "1L", category: beverages),
            Product(id: "SKU-BEV-005", name: "Apple Juice", productDescription: "Clear red apple juice.", price: 110.0, imageURLString: "drop.fill", unitDescription: "1L", category: beverages),
            Product(id: "SKU-BEV-006", name: "Coconut Water", productDescription: "Natural tender coconut juice.", price: 80.0, imageURLString: "drop.fill", unitDescription: "200 ml", category: beverages),
            Product(id: "SKU-BEV-007", name: "Cold Brew Coffee", productDescription: "Smooth bottled cold brew.", price: 150.0, imageURLString: "cup.and.saucer.fill", unitDescription: "250 ml", category: beverages),
            Product(id: "SKU-BEV-008", name: "Green Tea Bags", productDescription: "Honey lemon green tea.", price: 220.0, imageURLString: "leaf.fill", unitDescription: "25 bags", category: beverages),
            Product(id: "SKU-BEV-009", name: "Black Tea Leaves", productDescription: "Aromatic loose black tea.", price: 299.0, imageURLString: "leaf.fill", unitDescription: "500g", category: beverages),
            Product(id: "SKU-BEV-010", name: "Energy Drink", productDescription: "Classic functional energy.", price: 125.0, imageURLString: "bolt.fill", unitDescription: "250 ml", category: beverages),

            // Personal Care (10 items)
            Product(id: "SKU-PC-001", name: "Liquid Hand Wash", productDescription: "Antibacterial hand wash.", price: 99.0, imageURLString: "bubbles.and.sparkles.fill", unitDescription: "200 ml", category: personalCare),
            Product(id: "SKU-PC-002", name: "Fresh Shower Gel", productDescription: "Sea mineral body wash.", price: 199.0, imageURLString: "drop.fill", unitDescription: "250 ml", category: personalCare),
            Product(id: "SKU-PC-003", name: "Repair Shampoo", productDescription: "Hair strengthening shampoo.", price: 249.0, imageURLString: "drop.fill", unitDescription: "340 ml", category: personalCare),
            Product(id: "SKU-PC-004", name: "Hair Conditioner", productDescription: "Nourishing post-wash cream.", price: 210.0, imageURLString: "drop.fill", unitDescription: "175 ml", category: personalCare),
            Product(id: "SKU-PC-005", name: "Gel Toothpaste", productDescription: "Cooling mint toothpaste.", price: 95.0, imageURLString: "staroflife.fill", unitDescription: "150g", category: personalCare),
            Product(id: "SKU-PC-006", name: "Soft Toothbrush", productDescription: "CrissCross plaque brush.", price: 50.0, imageURLString: "pencil", unitDescription: "1 pc", category: personalCare),
            Product(id: "SKU-PC-007", name: "Neem Face Wash", productDescription: "Herbal face wash gel.", price: 120.0, imageURLString: "leaf.fill", unitDescription: "150 ml", category: personalCare),
            Product(id: "SKU-PC-008", name: "Moisturizing Cream", productDescription: "Light body moisturizer.", price: 180.0, imageURLString: "circle.fill", unitDescription: "200 ml", category: personalCare),
            Product(id: "SKU-PC-009", name: "Sunscreen SPF 50", productDescription: "Dry touch sun block.", price: 650.0, imageURLString: "sun.max.fill", unitDescription: "80 ml", category: personalCare),
            Product(id: "SKU-PC-010", name: "Deodorant Spray", productDescription: "Long lasting active spray.", price: 210.0, imageURLString: "bolt.fill", unitDescription: "150 ml", category: personalCare),

            // Household Essentials (10 items)
            Product(id: "SKU-HSH-001", name: "Dishwash Liquid", productDescription: "Lemon dishwashing cleaner.", price: 105.0, imageURLString: "drop.fill", unitDescription: "500 ml", category: household),
            Product(id: "SKU-HSH-002", name: "Laundry Detergent", productDescription: "Matik liquid detergent.", price: 220.0, imageURLString: "cylinder.fill", unitDescription: "1L", category: household),
            Product(id: "SKU-HSH-003", name: "Floor Cleaner", productDescription: "Disinfectant pine cleaner.", price: 135.0, imageURLString: "drop.fill", unitDescription: "1L", category: household),
            Product(id: "SKU-HSH-004", name: "Garbage Bags Large", productDescription: "Tough black waste bags.", price: 90.0, imageURLString: "square.fill", unitDescription: "30 bags", category: household),
            Product(id: "SKU-HSH-005", name: "Toilet Cleaner Liquid", productDescription: "Disinfectant blue toilet gel.", price: 85.0, imageURLString: "drop.fill", unitDescription: "500 ml", category: household),
            Product(id: "SKU-HSH-006", name: "Kitchen Paper Towels", productDescription: "Absorbent 2-ply rolls.", price: 120.0, imageURLString: "square.stack.fill", unitDescription: "2 rolls", category: household),
            Product(id: "SKU-HSH-007", name: "Cleaning Sponges", productDescription: "Heavy duty scrubs.", price: 50.0, imageURLString: "square.grid.2x2.fill", unitDescription: "3 pack", category: household),
            Product(id: "SKU-HSH-008", name: "Disinfectant Spray", productDescription: "Sanitizer surface spray.", price: 199.0, imageURLString: "wind", unitDescription: "170g", category: household),
            Product(id: "SKU-HSH-009", name: "Fabric Softener", productDescription: "Spring fresh conditioner.", price: 160.0, imageURLString: "drop.fill", unitDescription: "500 ml", category: household),
            Product(id: "SKU-HSH-010", name: "Glass Cleaner Spray", productDescription: "Streak-free glass cleaner.", price: 85.0, imageURLString: "drop.fill", unitDescription: "500 ml", category: household),

            // Baby Care (10 items)
            Product(id: "SKU-BAB-001", name: "Baby Wet Wipes", productDescription: "Alcohol free water wipes.", price: 150.0, imageURLString: "square.fill", unitDescription: "80 wipes", category: babyCare),
            Product(id: "SKU-BAB-002", name: "Baby No-Tears Shampoo", productDescription: "Mild baby clean shampoo.", price: 185.0, imageURLString: "drop.fill", unitDescription: "200 ml", category: babyCare),
            Product(id: "SKU-BAB-003", name: "Baby Nourishing Lotion", productDescription: "Soft skin baby moisturizer.", price: 170.0, imageURLString: "circle.fill", unitDescription: "200 ml", category: babyCare),
            Product(id: "SKU-BAB-004", name: "Baby Cooling Powder", productDescription: "Absorbent soothing talc.", price: 110.0, imageURLString: "circle.grid.2x2.fill", unitDescription: "200g", category: babyCare),
            Product(id: "SKU-BAB-005", name: "Baby Mild Soap", productDescription: "Hydrating clean baby soap.", price: 65.0, imageURLString: "square.fill", unitDescription: "75g", category: babyCare),
            Product(id: "SKU-BAB-006", name: "Baby Diapers Small", productDescription: "Absorbent diaper pants.", price: 399.0, imageURLString: "square.stack.fill", unitDescription: "36 pack", category: babyCare),
            Product(id: "SKU-BAB-007", name: "Baby Diapers Medium", productDescription: "Absorbent diaper pants.", price: 499.0, imageURLString: "square.stack.fill", unitDescription: "32 pack", category: babyCare),
            Product(id: "SKU-BAB-008", name: "Baby Massage Oil", productDescription: "Pure coconut massage oil.", price: 145.0, imageURLString: "drop.fill", unitDescription: "150 ml", category: babyCare),
            Product(id: "SKU-BAB-009", name: "Baby Face Cream", productDescription: "Mild soothing facial cream.", price: 120.0, imageURLString: "circle.fill", unitDescription: "50g", category: babyCare),
            Product(id: "SKU-BAB-010", name: "Baby Apple Oats Cereal", productDescription: "Nutritious grain baby food.", price: 215.0, imageURLString: "cart.fill", unitDescription: "300g", category: babyCare),

            // Pet Care (10 items)
            Product(id: "SKU-PET-001", name: "Dog Dry Food Chicken", productDescription: "High-protein dry food.", price: 350.0, imageURLString: "cart.fill", unitDescription: "1.2kg", category: petCare),
            Product(id: "SKU-PET-002", name: "Cat Dry Food Salmon", productDescription: "Taurine rich dry food.", price: 320.0, imageURLString: "cart.fill", unitDescription: "1.1kg", category: petCare),
            Product(id: "SKU-PET-003", name: "Dog Chicken Chew Bones", productDescription: "Calcium rich raw treats.", price: 150.0, imageURLString: "capsule.fill", unitDescription: "6 pcs", category: petCare),
            Product(id: "SKU-PET-004", name: "Clumping Cat Litter", productDescription: "High absorption bentonite.", price: 250.0, imageURLString: "circle.grid.2x2.fill", unitDescription: "5kg", category: petCare),
            Product(id: "SKU-PET-005", name: "Anti-Tick Pet Shampoo", productDescription: "Soothing clean formula.", price: 180.0, imageURLString: "drop.fill", unitDescription: "200 ml", category: petCare),
            Product(id: "SKU-PET-006", name: "Dog Bouncing Ball Toy", productDescription: "Bite-resistant rubber ball.", price: 95.0, imageURLString: "circle.fill", unitDescription: "1 pc", category: petCare),
            Product(id: "SKU-PET-007", name: "Cat Play Mouse Toy", productDescription: "Interactive plush mouse.", price: 65.0, imageURLString: "leaf.fill", unitDescription: "1 pc", category: petCare),
            Product(id: "SKU-PET-008", name: "Pet Grooming Brush", productDescription: "Soft metal de-shedding brush.", price: 199.0, imageURLString: "pencil", unitDescription: "1 pc", category: petCare),
            Product(id: "SKU-PET-009", name: "Fish Food Flakes", productDescription: "Daily nutrients fish flakes.", price: 99.0, imageURLString: "circle.grid.3x3.fill", unitDescription: "50g", category: petCare),
            Product(id: "SKU-PET-010", name: "Dog Nylon Leash", productDescription: "Strong adjustable lead leash.", price: 220.0, imageURLString: "capsule.fill", unitDescription: "1.5m", category: petCare)
        ]
    }()
}
