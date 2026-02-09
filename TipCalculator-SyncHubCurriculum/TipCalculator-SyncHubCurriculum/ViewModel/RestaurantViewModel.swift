//
//  RestaurantViewModel.swift
//  TipCalculator-SyncHubCurriculum
//
//  Created by Carson_Nov_2025 on 2/5/26.
//

import Foundation
internal import Combine

class RestaurantViewModel: ObservableObject {
    // MARK: - FIXED The ViewModel holds the Model
    @Published var restaurant: Restaurant

    init() {
        self.restaurant = Restaurant(name: "Steven's Kitchen", billAmount: 0.0, partySize: 1, tipPercentage: 15, totalRevenue: 0.0)
    }

    // MARK: - Intentions (User Actions)

    // MARK: - FIXED No Magic Numbers, Comment explains WHY (Gas costs), Function is well named and documented
    /// Calculates tip based on the restaurant's rules.
    /// - Returns: The calculated tip amount as a Double.
    internal func calculateTip() -> Double {
        let minimumTipThreshold = 20.0
        let minimumTipAmount = 5.0

        if restaurant.billAmount > minimumTipThreshold {
            let decimalPercent = Double(restaurant.tipPercentage) / 100.0
            return restaurant.billAmount * decimalPercent
        } else {
            // For small orders, we enforce a minimum tip to ensure staff pay.
            return minimumTipAmount
        }
    }
    
    // MARK: - FIXED Uses ViewModel to update the Model
    /// Adds the current calculated tip to the bill total.
    internal func applyTipToBill() {
        let tip = calculateTip()
        restaurant.totalRevenue += restaurant.billAmount + tip
        
        restaurant.billAmount = 0.0
    }
}
