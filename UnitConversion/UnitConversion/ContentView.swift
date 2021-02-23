//
//  ContentView.swift
//  UnitConversion
//
//  Created by austin_wood on 2/23/21.
//

import SwiftUI

struct ContentView: View {
    @State private var inputValue = "1"
    @State private var inputUnit: Unit = .kilometers
    @State private var outputUnit: Unit = .miles

    let formatter = NumberFormatter()

    enum Unit: String, CaseIterable {
        case meters, kilometers, feet, yards, miles, centimeters
    }

    var unitSymbols: [String] {
        Unit.allCases.map { unit in
            (UnitLength.value(forKey: unit.rawValue) as! UnitLength).symbol
        }
    }

    var outputValue: Double {
        let inputValue = Double(self.inputValue) ?? 0
        let inputUnit  = UnitLength.value(forKey: self.inputUnit.rawValue) as! UnitLength
        let outputUnit = UnitLength.value(forKey: self.outputUnit.rawValue) as! UnitLength

        let inputMeasurement = Measurement(value: inputValue, unit: inputUnit)
        let baseMeasurement = inputMeasurement.converted(to: UnitLength.meters)
        let outputMeasurement = baseMeasurement.converted(to: outputUnit)

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
                    Text("\(formatNumber(number: outputValue))")

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

    func formatNumber(number: Double) -> String {
        formatter.usesSignificantDigits = true
        return formatter.string(from: NSNumber(value: number)) ?? ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}