//
//  RestaurantView.swift
//  TipCalculator-SyncHubCurriculum
//
//  Created by Carson_Nov_2025 on 2/5/26.
//

import SwiftUI

struct RestaurantView: View {
    // MARK: - Connecting to ViewModel, proper visibility
    @StateObject private var viewModel = RestaurantViewModel()
    @State private var currentTip: Double = 0.0

    var body: some View {
        VStack(spacing: 20) {
            Text("\(viewModel.restaurant.name) Tip Calculator")
                .font(.largeTitle)
                .bold()
                .padding(10)

            // MARK: - FIXED Binding directly to the ViewModel's model data rather than holding locally
            Stepper("Party Size: \(viewModel.restaurant.partySize)",
                    value: $viewModel.restaurant.partySize,
                    in: 1...12)
            
            Stepper("Tip Percent: \(viewModel.restaurant.tipPercentage)%",
                    value: $viewModel.restaurant.tipPercentage,
                    in: 0...25)

            HStack {
                Text("Bill:")
                Spacer()
                // MARK: - FIXED Binding to the model
                TextField("Amount", value: $viewModel.restaurant.billAmount, format: .number)
                    .keyboardType(.decimalPad)
                    .frame(width: 90)
                    .multilineTextAlignment(.trailing)
                    .textFieldStyle(.roundedBorder)
            }
            .padding(.horizontal)

            Button("Calculate Tip") {
                // MARK: - FIXED View asks ViewModel to do the work
                currentTip = viewModel.calculateTip()
            }
            .padding(16)
            .background(
                Color(uiColor: .systemGray6)
            )
            .cornerRadius(24)
            
            Button("Add Tip to Bill") {
                // MARK: - Using ViewModel to write to Model
                viewModel.applyTipToBill()
            }
            .padding(16)
            .background(
                Color(uiColor: .systemGray6)
            )
            .cornerRadius(24)

            Spacer()

            Text("Total Tip: \(currentTip, format: .currency(code: "USD"))")
                .font(.largeTitle)
                .bold()
            
            Text("Total Revenue: \(viewModel.restaurant.totalRevenue, format: .currency(code: "USD"))")
                .font(.largeTitle)
                .bold()
        }
        .padding()
    }
}

// MARK: FIXED No business logic functions at bottom of view

#Preview {
    RestaurantView()
}
