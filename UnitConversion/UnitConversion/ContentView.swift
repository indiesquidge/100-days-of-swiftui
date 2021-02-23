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

    var outputValue: Double {
        let inputValue = Double(self.inputValue) ?? 0
        let inputUnit  = getUnit(for: self.inputUnit.rawValue)
        let outputUnit = getUnit(for: self.outputUnit.rawValue)

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
                        ForEach(Unit.allCases, id: \.self) { unit in
                            Text("\(getUnit(for: unit.rawValue).symbol)")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("Output")) {
                    Text("\(formatNumber(number: outputValue))")

                    Picker("Input unit", selection: $outputUnit) {
                        ForEach(Unit.allCases, id: \.self) { unit in
                            Text("\(getUnit(for: unit.rawValue).symbol)")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationBarTitle("Length Converter")
        }
    }

    func getUnit(for key: String) -> UnitLength {
        UnitLength.value(forKey: key) as! UnitLength
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
