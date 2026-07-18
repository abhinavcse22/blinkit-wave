import Foundation

/// Pure component responsible for evaluating deadline actions, batch totals, and slots to construct recommendations.
struct RecommendationEngine {
    /// Injected business configurations.
    let configuration: EngineConfiguration

    /// Compiles all calculations into a single unified WaveRecommendation response.
    /// - Parameters:
    ///   - cart: The primary user cart.
    ///   - batchResult: Matched order batch metrics.
    ///   - predictedSlot: Forecasted wave slot parameters.
    ///   - deadlineAction: SLA evaluation timing action.
    ///   - riderAvailable: Flag specifying if riders are on standby.
    ///   - inventoryAvailable: Flag specifying if store stocks are ready.
    ///   - currentTime: The reference time of checkout execution.
    /// - Returns: Unified WaveRecommendation structure.
    func generateRecommendation(
        cart: Cart,
        batchResult: BatchOptimizationResult,
        predictedSlot: WaveSlot,
        deadlineAction: DeadlineAction,
        riderAvailable: Bool,
        inventoryAvailable: Bool,
        currentTime: Date
    ) -> WaveRecommendation {
        let isFree = batchResult.isEligibleForFreeDelivery
        let deliveryFee = isFree ? 0.0 : configuration.standardDeliveryFee
        let savings = batchResult.estimatedSavings
        
        let estimatedETA: Date
        let waveType: WaveType
        let waveStatus: WaveStatus
        let explanation: String
        let primaryOption: DeliveryOption
        
        var alternatives: [AIRecommendation] = []
        let expiryDate = Date(timeInterval: 300.0, since: currentTime) // Valid for 5 minutes
        
        // Generate deterministic wave identifier from cart ID to maintain purity.
        let cartSeed = stableHash(cart.id.uuidString)
        let waveID = "WAVE-LIVE-\(cartSeed % 10000)"
        
        // Ensure dispatch and rider constraints. If resources are down, fallback to instant.
        let canFulfillWave = riderAvailable && inventoryAvailable
        
        if !canFulfillWave {
            primaryOption = .instant(fee: configuration.standardDeliveryFee)
            estimatedETA = Date(timeInterval: 600.0, since: currentTime) // 10 minutes ETA
            waveType = .live
            waveStatus = .completed
            explanation = "Batch delivery is temporarily suspended due to rider shortages or item out-of-stocks. Proceeding with instant delivery."
        } else {
            switch deadlineAction {
            case .dispatchNow:
                primaryOption = .liveWave(waveID: waveID)
                estimatedETA = Date(timeInterval: 900.0, since: currentTime) // 15 minutes dispatch
                waveType = .live
                waveStatus = .confirmed
                explanation = "Free Delivery Wave confirmed! Your neighborhood batch has met the free delivery threshold. Dispatching now."
                
            case .wait:
                if isFree {
                    primaryOption = .liveWave(waveID: waveID)
                    estimatedETA = Date(timeInterval: 600.0, since: currentTime) // 10 minutes
                    waveType = .live
                    waveStatus = .assembling
                    explanation = "A Live Free Delivery Wave is assembling near you. Joining now guarantees free delivery before your deadline."
                } else {
                    primaryOption = .scheduledWave(slotID: predictedSlot.id)
                    estimatedETA = predictedSlot.startTime
                    waveType = .scheduled
                    waveStatus = .assembling
                    explanation = "Save ₹\(Int(configuration.standardDeliveryFee)) by scheduling your order. The predicted wave slot has high neighborhood density."
                    
                    // Add Live Wave as a fee alternative
                    alternatives.append(AIRecommendation(
                        recommendedOption: .liveWave(waveID: waveID),
                        savingsAmount: 0.0,
                        explanationText: "Join current Live Wave (Delivery Fee: ₹\(Int(configuration.standardDeliveryFee)))",
                        expiresAt: expiryDate
                    ))
                }
                
            case .fallbackToInstant:
                primaryOption = .instant(fee: configuration.standardDeliveryFee)
                estimatedETA = Date(timeInterval: 600.0, since: currentTime)
                waveType = .live
                waveStatus = .completed
                explanation = "No matching neighborhood batch could meet the free delivery threshold before your deadline. Proceeding with instant delivery."
                
                // Suggest Smart Wallet as a savings alternative
                let cartTotal = cart.items.reduce(0.0) { sum, item in
                    guard let product = item.product else { return sum }
                    return sum + (product.price * Double(item.quantity))
                }
                let missingAmount = max(0.0, configuration.freeDeliveryThreshold - cartTotal)
                alternatives.append(AIRecommendation(
                    recommendedOption: .smartWallet,
                    savingsAmount: configuration.standardDeliveryFee,
                    explanationText: "Add ₹\(Int(missingAmount)) to Smart Wallet to unlock FREE delivery.",
                    expiresAt: expiryDate
                ))
                
            case .suggestSmartWallet:
                primaryOption = .smartWallet
                estimatedETA = Date(timeInterval: 900.0, since: currentTime)
                waveType = .live
                waveStatus = .assembling
                explanation = "Your order does not meet the ₹\(Int(configuration.freeDeliveryThreshold)) threshold. Deposit the remaining balance into your Smart Wallet to unlock free delivery instantly."
                
                // Suggest Instant delivery as a fallback alternative
                alternatives.append(AIRecommendation(
                    recommendedOption: .instant(fee: configuration.standardDeliveryFee),
                    savingsAmount: 0.0,
                    explanationText: "Pay standard delivery fee of ₹\(Int(configuration.standardDeliveryFee)) for instant checkout.",
                    expiresAt: expiryDate
                ))
            }
        }
        
        let primaryRec = AIRecommendation(
            recommendedOption: primaryOption,
            savingsAmount: savings,
            explanationText: explanation,
            expiresAt: expiryDate
        )
        
        // Ensure alternatives always include Instant Delivery if it wasn't chosen as primary
        if case .instant = primaryOption {} else {
            alternatives.append(AIRecommendation(
                recommendedOption: .instant(fee: configuration.standardDeliveryFee),
                savingsAmount: 0.0,
                explanationText: "Instant Delivery (ETA 10m, fee: ₹\(Int(configuration.standardDeliveryFee)))",
                expiresAt: expiryDate
            ))
        }
        
        return WaveRecommendation(
            primaryRecommendation: primaryRec,
            alternativeRecommendations: alternatives,
            batchResult: batchResult,
            predictedWaveSlot: predictedSlot,
            deadlineAction: deadlineAction,
            estimatedSavings: savings,
            estimatedDeliveryFee: deliveryFee,
            estimatedETA: estimatedETA,
            confidence: predictedSlot.predictedConfidence,
            waveType: waveType,
            waveStatus: waveStatus,
            isFreeDelivery: isFree,
            explanation: explanation
        )
    }
    
    /// Stable hashing function for puristic ID derivation.
    private func stableHash(_ string: String) -> Int {
        string.utf8.reduce(0) { $0 + Int($1) }
    }
}
