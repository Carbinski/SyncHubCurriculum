//
//  PaymentViewModel.swift
//  MVVMDemo
//
//  Created by Carson_Nov_2025 on 2/10/26.
//

import Foundation
internal import Combine

class RestaurantViewModel: ObservableObject {
    @Published var restaurant: Restaurant
    
    init() {
        self.restaurant = Restaurant(name: "Steven's Kitchen", billAmount: 0.0, partySize: 1, tipPercentage: 15, totalRevenue: 0.0, currentTip: 0.0)
    }
    
    // MARK: - Business Logic of Restaurant
    
    /// Calculates Tip
    ///
    /// Parameter - billAmount: The amount on the current bill
    /// Parameter - tip: percent value of the tip
    /// Return - the amount tipped
    public func calculateTip() {
        let tipPercent = Double(restaurant.tipPercentage) / 100.0
        let minimumBillSize = 20.0
        
        // People need to tip if they spend under 20 becuase we wnato pay our waiters
        if restaurant.billAmount > minimumBillSize {
            restaurant.currentTip = restaurant.billAmount * tipPercent
        } else {
            restaurant.currentTip = 5.0
        }
    }
    
    public func addTipToBill() {
        restaurant.totalRevenue += restaurant.currentTip + restaurant.billAmount
        restaurant.billAmount = 0.0
        restaurant.currentTip = 0.0
    }
    
}
