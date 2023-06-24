//
//  ContentView.swift
//  BetterRest
//
//  Created by Yue ZHENG on 6/23/23.
//

import SwiftUI
import CoreML

struct ContentView: View {
    
    @State private var wakeUp = defaultWakeUp
    @State private var sleepAmount = 8.0
    @State private var coffeAmount = 1
    
    // alert
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeUp: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        NavigationStack{
            Form {
                
                VStack(alignment: .leading) {
                    Text("When do you want to wake up").font(.headline)
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute).labelsHidden()
                }
                
                VStack(alignment: .leading) {
                    Text("Desired amount of sleep").font(.headline)
                    Stepper("\(sleepAmount.formatted())  hours", value: $sleepAmount, in: 4...12, step: 0.5)
                }
                
                VStack(alignment: .leading) {
                    Text("Daily Coffe intake").font(.headline)
                    Stepper((coffeAmount == 1) ? "1 cup" : "\(coffeAmount) cups", value: $coffeAmount, in: 0...20)
                }
               
            }
            .navigationTitle("Better Rest")
            .toolbar {
                Button("Calculate") {
                    calculateBedtime()
                }
            }
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK"){}
            } message: {
                Text(alertMessage)
            }
        }

    }
    
    func calculateBedtime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            //More code to come here
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour+minute), estimatedSleep: Double(sleepAmount), coffee: Double(coffeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            alertTitle = "Your bedtime is ..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            
        } catch {
            alertTitle = "Error"
            alertMessage = "Oops, something goes wrong when calculating your bedtime"
        }
        
        showingAlert = true
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
