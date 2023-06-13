enum TemperatureUnit: String, CaseIterable {
    case Fahrenheit
    case Celsius
    case Kelvin
}

import SwiftUI

struct ContentView: View {
    @State private var inputTemperUnit: TemperatureUnit = .Fahrenheit
    @State private var outputTemperUnit: TemperatureUnit = .Celsius
    @State private var inputTemperature: Double = Double()
    
    @FocusState private var amountIsFocused: Bool

        
    var outputTemperature: Double {
        switch inputTemperUnit {
        case .Fahrenheit:
            switch outputTemperUnit {
            case .Fahrenheit:
                return inputTemperature
            case .Celsius:
                return (inputTemperature - 32.0) * 5.0 / 9.0
            case .Kelvin:
                return ((inputTemperature - 32.0) * 5.0 / 9.0) + 273.15
            }
        case .Celsius:
            switch outputTemperUnit {
            case .Fahrenheit:
                return (inputTemperature * 9.0 / 5.0) + 32.0
            case .Celsius:
                return inputTemperature
            case .Kelvin:
                return inputTemperature + 273.15
            }
        case .Kelvin:
            switch outputTemperUnit {
            case .Fahrenheit:
                return ((inputTemperature - 273.15) * 9.0 / 5.0) + 32.0
            case .Celsius:
                return inputTemperature - 273.15
            case .Kelvin:
                return inputTemperature
            }
        }
    
    }
        
    var body: some View {
        NavigationStack{
            Form {
                Section {
                    Picker("Input Temperature Units", selection: $inputTemperUnit) {
                        ForEach(TemperatureUnit.allCases, id: \.self) { tempUnit in
                            Text(tempUnit.rawValue)
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("Original temperature unit")
                }
                
                Section {
                    TextField("Input Temperature", value: $inputTemperature, format: .number, prompt: Text("Original"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                } header: {
                    Text("Original temperature")
                }
                
                Section {
                    Picker("Output Temperature Units", selection: $outputTemperUnit) {
                        ForEach(TemperatureUnit.allCases, id: \.self) { tempUnit in
                            Text(tempUnit.rawValue)
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("Convert to")
                }
                
                Section {
                    Text(outputTemperature, format: .number)
                } header: {
                    Text("Converted temperature")
                }
            }
            .navigationTitle(Text("🌡️ Convertor"))
            .toolbar{
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
