//
//  ContentView.swift
//  TipCalculator-SyncHubCurriculum
//
//  Created by Carson_Nov_2025 on 2/5/26.
//

import SwiftUI
import UIKit
import Foundation

struct ContentView: View {
    @StateObject private var viewModel = RestaurantViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Tip Calculator!")
                .font(Font.largeTitle)
                .bold(true)
                .padding(10)
            
            Stepper("Party Size: \(viewModel.restaurant.partySize)", value: $viewModel.restaurant.partySize, in: 1...12)
            Stepper("Tip Percent: \(viewModel.restaurant.tipPercentage)%", value: $viewModel.restaurant.tipPercentage, in: 0...25)
            HStack {
                Text("Bill:")
                Spacer()
                TextField("Amount", value:
                            $viewModel.restaurant.billAmount, format: .number)
                    .keyboardType(.decimalPad)
                    .frame(width: 90)
                    .multilineTextAlignment(.trailing)
                    .background(Color(uiColor: .systemGray2))
                    .textFieldStyle(.roundedBorder
                    )
                    .cornerRadius(24)
                    
            }
            
            Button("Calculate Tip") {
                viewModel.calculateTip()
            }
            .padding(16)
            .background(
                Color(uiColor: .systemGray6)
            )
            .cornerRadius(24)
            
            Button("Add Tip to Bill") {
                viewModel.addTipToBill()
            }
            .padding(16)
            .background(
                Color(uiColor: .systemGray6)
            )
            .cornerRadius(24)
            
            Spacer()
            
            Text("Total Tip: \(viewModel.restaurant.currentTip, format: .currency(code: "USD"))")
                .font(.largeTitle)
                .bold()
            
            Text("Total Revenue: \(viewModel.restaurant.totalRevenue, format: .currency(code: "USD"))")
                .font(.largeTitle)
                .bold()
        }
        .padding()
    }
}



#Preview {
    ContentView()
}
