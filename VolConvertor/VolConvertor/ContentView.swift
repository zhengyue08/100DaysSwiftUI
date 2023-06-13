//
//  ContentView.swift
//  VolConvertor
//
//  Created by Yue ZHENG on 6/13/23.
//


import SwiftUI

enum VolumeUnits: String, CaseIterable {
    case cup
    case mL
    case pt
    case gal
    case L
}

// map String to UnitVolume
let volUnitsDic: [String: UnitVolume] = [VolumeUnits.cup.rawValue: .cups, VolumeUnits.mL.rawValue: .milliliters, VolumeUnits.pt.rawValue: .pints, VolumeUnits.gal.rawValue: .gallons, VolumeUnits.L.rawValue: .liters]

let volumeUnits = Array(volUnitsDic.keys).sorted()

struct ContentView: View {
        
    @State private var originalVolUnit :String = VolumeUnits.cup.rawValue
    @State private var convertedVolUnit:String = VolumeUnits.L.rawValue
    @State private var originalVol: Double = 0.0
    
    @FocusState private var amountIsFocused: Bool

    // convert
    var convertedVol: Double {
        let originVolMea = Measurement(value: originalVol, unit: volUnitsDic[originalVolUnit]!)
        return originVolMea.converted(to: volUnitsDic[convertedVolUnit]!).value
    }
    

    var body: some View {
        NavigationStack{
            Form {
                Section {
                    Picker("Original Volume Units", selection: $originalVolUnit) {
                        ForEach(volumeUnits, id: \.self) { volUnit in
                            Text(volUnit)
                        }
                    }
                } header: {
                    Text("Original volume unit")
                }
                
                Section {
                    TextField("Original Volume", value: $originalVol, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                } header: {
                    Text("Original volume")
                }
                
                Section {
                    Picker("Converted Volume Units", selection: $convertedVolUnit) {
                        ForEach(volumeUnits, id: \.self) { volUnit in
                            Text(volUnit)
                        }
                    }
                } header: {
                    Text("Convert to")
                }
                
                Section {
                    Text(convertedVol, format: .number)
                } header: {
                    Text("Converted volume")
                }
            }
            .navigationTitle(Text("Vol Convertor"))
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
