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
    
    let coffeIntakeCups = 0...20

    //challenge
    
    
    var sleepTime: String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            //More code to come here
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour+minute), estimatedSleep: Double(sleepAmount), coffee: Double(coffeAmount))
            
            return (wakeUp - prediction.actualSleep).formatted(date: .omitted, time: .shortened)
            
            
        } catch {
            return Date.now.formatted(date: .omitted, time: .shortened)
        }
        
    }
    
    
    
    static var defaultWakeUp: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        NavigationStack{
            Form {
                
                Section {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute).labelsHidden()
                } header: {
                    Text("When do you want to wake up").font(.headline)
                }
                
                Section {
                    Stepper("\(sleepAmount.formatted())  hours", value: $sleepAmount, in: 4...12, step: 0.5)
                } header: {
                    Text("Desired amount of sleep").font(.headline)
                }
                
                Section {
//                    Stepper((coffeAmount == 1) ? "1 cup" : "\(coffeAmount) cups", value: $coffeAmount, in: 0...20)
                    
                    Picker("Daily Coffe intake", selection: $coffeAmount) {
                        ForEach(coffeIntakeCups, id: \.self) { cup in
                            Text((cup == 1 || cup == 0) ? "\(cup) cup" : "\(cup) cups")
                        }
                    }
                    
                } header: {
                    Text("Daily Coffe intake").font(.headline)
                }
                
                //challenge
                Section{
                    Text(sleepTime).font(.largeTitle).frame(maxWidth: .infinity, alignment: .center)
                } header: {
                    Text("ideal Bedtime")
                }
               
            }
            .navigationTitle("Better Rest")
//            .toolbar {
//                Button("Calculate") {
//                    calculateBedtime()
//                }
//            }
//            .alert(alertTitle, isPresented: $showingAlert) {
//                Button("OK"){}
//            } message: {
//                Text(alertMessage)
//            }
            
        }

    }
    
//    func calculateBedtime() {
//        do {
//            let config = MLModelConfiguration()
//            let model = try SleepCalculator(configuration: config)
//
//            //More code to come here
//            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
//            let hour = (components.hour ?? 0) * 60 * 60
//            let minute = (components.minute ?? 0) * 60
//
//            let prediction = try model.prediction(wake: Double(hour+minute), estimatedSleep: Double(sleepAmount), coffee: Double(coffeAmount))
//
//            let sleepTime = wakeUp - prediction.actualSleep
//
//            alertTitle = "Your bedtime is ..."
//            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
//
//        } catch {
//            alertTitle = "Error"
//            alertMessage = "Oops, something goes wrong when calculating your bedtime"
//        }
//
//        showingAlert = true
//
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
