//
//  ContentView.swift
//  WeSplit
//
//  Created by Ahsan Qureshi on 3/8/24.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [15, 20, 25, 0]
    let currencyCode = Locale.current.currency?.identifier ?? "USD"
    
    var total: Double {
        checkAmount * Double(100 + tipPercentage) / 100
    }
    var totalPerPerson: Double {
        total / Double(numberOfPeople)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount",
                              value: $checkAmount,
                              format: .currency(code: currencyCode))
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100, id: \.self) {
                            Text("\($0) People")
                        }
                    }
                }
                
                Section("How much tip do you want to leave?") {
                    Picker("Tip %: ", selection: $tipPercentage) {
                        ForEach(0..<101, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("Total") {
                    Text(total, format: .currency(code: currencyCode))
                }
                
                Section("Amount per person") {
                    Text(totalPerPerson, format: .currency(code: currencyCode))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused.toggle()
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
