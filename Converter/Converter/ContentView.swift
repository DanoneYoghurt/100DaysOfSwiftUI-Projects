//
//  ContentView.swift
//  Converter
//
//  Created by Антон Баскаков on 19.04.2024.
//

import SwiftUI
struct ContentView: View {
    let picker = ["Цельсий", "Кельвин", "Фаренгейт"]
    @State private var inputUnit = 0.0
    @State private var pickedInputUnit = "Цельсий"
    @State private var pickedOutputUnit = "Цельсий"
    @FocusState private var inputUnitIsFocused: Bool
    var convertedToCelsiusInputUnit: Double {
        if pickedInputUnit == "Фаренгейт" {
            return (inputUnit - 32) * 5 / 9
        }
        if pickedInputUnit == "Кельвин" {
            return inputUnit - 273
        }
        else {
            return inputUnit
        }
    }
    var outputUnit: Double {
        if pickedOutputUnit == "Фаренгейт" {
            return (convertedToCelsiusInputUnit * 9 / 5) + 32
        }
        if pickedOutputUnit == "Кельвин" {
            return convertedToCelsiusInputUnit + 273
        }
        else {
            return convertedToCelsiusInputUnit
        }
    }
    var body: some View {
        
        NavigationStack {
            Form {
                Section("Ввод") {
                    Picker("Выберите формат", selection: $pickedInputUnit) {
                        ForEach(picker, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    TextField("Значение", value: $inputUnit, format: .number)
                    .keyboardType(.default)
                    .focused($inputUnitIsFocused)
                }
                Section("Результат") {
                    Picker("Выберите формат", selection: $pickedOutputUnit){
                        ForEach(picker, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    Text(outputUnit, format: .number)
                    
                }
            }
            .navigationTitle("Конвертер")
            .toolbar {
                if inputUnitIsFocused {
                    Button("Готово") {
                        inputUnitIsFocused = false
                    }
                }
            }
        }
        
    }
}

#Preview {
    ContentView()
}
