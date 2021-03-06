//
//  ContentView.swift
//  BetterRest
//
//  Created by Austin Wood on 8/23/20.
//  Copyright © 2020 Austin Wood. All rights reserved.
//

import SwiftUI
import CoreML

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 1
    
    var idealBedtime: String {
        do {
            let model: SleepCalculator = try SleepCalculator(configuration: MLModelConfiguration())

            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            return formatter.string(from: sleepTime)
        } catch {
            return "Error: \(error.localizedDescription)"
        }
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("When do you want to wake up?").font(.headline)) {
                    
                    DatePicker(
                        "Please enter a time",
                        selection: $wakeUp,
                        displayedComponents: .hourAndMinute
                    )
                    .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                    
                }

                Section(header: Text("Desired amount of sleep").font(.headline)) {
                    
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                        // Why does VO read this out as "8 hours" even when
                        // sleepAmount changes from 8?
                        Text("\(sleepAmount, specifier: "%g") hours")
                            // Why does VO still read this text out?
                            .accessibility(hidden: true)
                    }
                    .accessibility(
                        value: Text("\(sleepAmount, specifier: "%g") hours"))
                    
                    
                }

                Section(header: Text("Daily coffee intake").font(.headline)) {
                    Picker(selection: $coffeeAmount, label: Text(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups")) {
                        ForEach(1...20, id: \.self) {
                            Text($0 == 1 ? "1 cup" : "\($0) cups")
                        }
                    }
                    .accessibility(value: Text("\(coffeeAmount) cups out of 20"))
                }

                Section(header: Text("Ideal bedtime").font(.headline)) {
                    HStack {
                        Spacer()
                        Text(idealBedtime).font(.title)
                        Spacer()
                    }
                }
            }
                
            .navigationBarTitle("BetterRest")
        }
    }
    
    // static means this property belongs to the ContentView itself rather than
    // an instance of that struct. This means the property doesn't rely on any
    // other properties
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
