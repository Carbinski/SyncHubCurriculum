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
    // MARK: - BAD PRACTICE: Vague Variable Names
    @State private var p: Int = 1
    @State private var t: Int = 15
    @State private var a: Double = 0.0
    @State private var tip: Double = 0.0
    // MARK: - BAD PRACTICE: Storing information about restaurant in view, poor naming convention
    var RestaurantName: String = "Steven's Kitchen"
    @State var Total: Double = 0.0
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Tip Calculator!")
                .font(Font.largeTitle)
                .bold(true)
                .padding(10)
            
            // MARK: - BAD PRACTICE: UI directly changing state
            Stepper("Party Size: \(p)", value: $p, in: 1...12)
            Stepper("Tip Percent: \(t)%", value: $t, in: 0...25)
            HStack {
                Text("Bill:")
                Spacer()
                TextField("Amount", value: $a, format: .number)
                    .keyboardType(.decimalPad)
                    .frame(width: 90)
                    .multilineTextAlignment(.trailing)
                    .background(Color(uiColor: .systemGray2))
                    .textFieldStyle(.roundedBorder
                    )
                    .cornerRadius(24)
                    
            }
            
            Button("Calculate Tip") {
                // MARK: - BAD PRACTICE: Logic inside the View
                tip = t_calculate(b: a, t: t)
            }
            .padding(16)
            .background(
                Color(uiColor: .systemGray6)
            )
            .cornerRadius(24)
            
            Button("Add Tip to Bill") {
                // MARK: - BAD PRACTICE: Logic inside the View
                Total = Total + tip + a
                a = 0.0
                tip = 0.0
            }
            .padding(16)
            .background(
                Color(uiColor: .systemGray6)
            )
            .cornerRadius(24)
            
            Spacer()
            
            Text("Total Tip: \(tip, format: .currency(code: "USD"))")
                .font(.largeTitle)
                .bold()
            
            Text("Total Revenue: \(Total, format: .currency(code: "USD"))")
                .font(.largeTitle)
                .bold()
        }
        .padding()
    }
}

// MARK: - BAD PRACTICE: Non-Descriptive Function Name & Magic Numbers
func t_calculate(b: Double, t: Int) -> Double {
    var t_double = Double(t) / 100.0
    
    if b > 20 {
        return b * t_double
    } else {
        return 5.0
    }
}

#Preview {
    ContentView()
}

