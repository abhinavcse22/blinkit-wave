import Foundation

/// Public facade orchestrator for coordinates matching, batch optimization, forecasting, and SLA timeline evaluations.
struct SmartWaveEngine {
    /// Injected configuration settings.
    let configuration: EngineConfiguration
    
    private let radiusMatcher: RadiusMatcher
    private let batchOptimizer: BatchOptimizer
    private let predictionEngine: WavePredictionEngine
    private let deadlineEngine: DeadlineEngine
    private let recommendationEngine: RecommendationEngine

    /// Initializes the engine with custom configuration parameters.
    /// - Parameter configuration: The rule settings to apply.
    init(configuration: EngineConfiguration = .defaultConfiguration) {
        self.configuration = configuration
        self.radiusMatcher = RadiusMatcher(configuration: configuration)
        self.batchOptimizer = BatchOptimizer(configuration: configuration)
        self.predictionEngine = WavePredictionEngine(configuration: configuration)
        self.deadlineEngine = DeadlineEngine(configuration: configuration)
        self.recommendationEngine = RecommendationEngine(configuration: configuration)
    }

    /// Evaluates checkout parameters to compute a recommendation result.
    /// - Parameters:
    ///   - user: The ordering user profile.
    ///   - cart: The active cart content list.
    ///   - deadline: Chosen delivery deadline.
    ///   - nearbyOrders: Pool of open neighbor orders.
    ///   - riderAvailable: Status of courier availability.
    ///   - inventoryAvailable: Status of local store stocks.
    ///   - currentTime: Chronological timestamp of evaluation.
    /// - Returns: Complete, unified WaveRecommendation output.
    func evaluate(
        user: User,
        cart: Cart,
        deadline: Date,
        nearbyOrders: [Order],
        riderAvailable: Bool,
        inventoryAvailable: Bool,
        currentTime: Date
    ) -> WaveRecommendation {
        // Fallback address mapping if the user has no defined addresses.
        let centerAddress = user.addresses.first ?? Address(
            label: "Default Locality",
            streetAddress: "Sector 62",
            city: "Noida",
            state: "Uttar Pradesh",
            postalCode: "201301",
            country: "India",
            latitude: 28.6273,
            longitude: 77.3725
        )
        
        // 1. Proximity matching
        let matched = radiusMatcher.findNearbyOrders(center: centerAddress, candidates: nearbyOrders)
        
        // 2. Financial bundle calculations
        let batchResult = batchOptimizer.optimize(cart: cart, matchedOrders: matched)
        
        // 3. AI prediction slot simulation
        let predictedSlot = predictionEngine.predictNextSlot(currentTime: currentTime, postalCode: centerAddress.postalCode)
        
        // 4. SLA timer evaluations
        let deadlineAction = deadlineEngine.evaluateDeadline(
            currentTime: currentTime,
            deadline: deadline,
            isThresholdMet: batchResult.isEligibleForFreeDelivery
        )
        
        // 5. Final recommendations compiler
        return recommendationEngine.generateRecommendation(
            cart: cart,
            batchResult: batchResult,
            predictedSlot: predictedSlot,
            deadlineAction: deadlineAction,
            riderAvailable: riderAvailable,
            inventoryAvailable: inventoryAvailable,
            currentTime: currentTime
        )
    }
}
