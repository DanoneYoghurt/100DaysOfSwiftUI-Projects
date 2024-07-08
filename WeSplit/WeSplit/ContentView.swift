//
//  ContentView.swift
//  WeSplit
//
//  Created by Антон Баскаков on 16.04.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    let tipPercentages = 0..<101
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    var grandTotal: Double {
        let grandTotal = checkAmount + ((checkAmount / 100) * Double(tipPercentage))
        return grandTotal
    }
    var body: some View {
        NavigationStack {
            Form {
                Section("Введите количество людей и сумму") {
                    TextField("Количество", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Количество людей", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) человек")
                        }
                    }
                    .pickerStyle(.wheel)
                }
                Section("Какой процент чаевых вы хотите оставить?") {
                    Picker("Процент чаевых", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.menu)

                }
                Section("Счет учитывая чаевые") {
                    Text(grandTotal, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .foregroundStyle(tipPercentage == 0 ? .red : .primary)
                }
                Section("Итого на человека") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Готово") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
