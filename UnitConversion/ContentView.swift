//
//  ContentView.swift
//  UnitConversion
//
//  Created by austin_wood on 2/23/21.
//

import SwiftUI

struct ContentView: View {
    @State private var inputValue = "1"
    @State private var inputUnit = 1
    @State private var outputUnit = 4

    let units = ["meters", "kilometers", "feet", "yards", "miles", "centimeters"]

    var unitSymbols: [String] {
        units.map { unit in
            (UnitLength.value(forKey: unit) as! UnitLength).symbol
        }
    }

    var outputValue: Double {
        let inputValue = Double(self.inputValue) ?? 0
        let inputUnit  = units[self.inputUnit]
        let outputUnit = units[self.outputUnit]

        let inputMeasurement =
            Measurement(value: inputValue, unit: UnitLength.value(forKey: inputUnit) as! UnitLength)
        let baseMeasurement = inputMeasurement.converted(to: UnitLength.meters)
        let outputMeasurement =
            baseMeasurement.converted(to: UnitLength.value(forKey: outputUnit) as! UnitLength)

        return outputMeasurement.value
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Input")) {
                    TextField("Input value", text: $inputValue).keyboardType(.decimalPad)

                    Picker("Output unit", selection: $inputUnit) {
                        ForEach(0 ..< unitSymbols.count) { index in
                            Text("\(self.unitSymbols[index])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("Output")) {
                    Text("\(outputValue)")

                    Picker("Input unit", selection: $outputUnit) {
                        ForEach(0 ..< unitSymbols.count) { index in
                            Text("\(self.unitSymbols[index])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationBarTitle("Length Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
