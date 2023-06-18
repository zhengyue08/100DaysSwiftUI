//
//  ContentView.swift
//  WeSplit
//
//  Created by Yue ZHENG on 6/10/23.
//

import SwiftUI



struct ContentView: View {
    @State private var checkAmount: Double = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 10

    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = 0..<101
    
    var tipValue :Double {
        return checkAmount / 100.0 * Double(tipPercentage)
    }
    
    var totalAmount: Double {
        return tipValue + checkAmount
    }
    
    var perPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let onePerson = totalAmount / peopleCount
        return onePerson
    }
    
    let currencyType = FloatingPointFormatStyle<Double>.Currency.currency(code: Locale.current.currency?.identifier ?? "USD")
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD")).keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<100) { number in
                            Text("\(number) people")
                        }
                    }
                }
                
                Section {
                    Picker ("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) { percentage in
                            Text(percentage, format: .percent)
                        }
                    }
                } header: {
                    Text ("How much tip do you want to leave")
                }
                
                Section {
                    Text (totalAmount, format: currencyType)
                } header: {
                    Text ("Total amount")
                }.foregroundColor( (tipPercentage == 0) ? .red: Color.primary)
                
                Section {
                    Text(perPerson, format: currencyType)
                } header: {
                    Text("Amount per person")
                }

                
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
