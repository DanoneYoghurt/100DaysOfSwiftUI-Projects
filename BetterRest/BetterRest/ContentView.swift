//
//  ContentView.swift
//  BetterRest
//
//  Created by Антон Баскаков on 02.05.2024.
//

import CoreML
import SwiftUI

struct ContentView: View {
    
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    var bedtime: Date {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let result = wakeUp - prediction.actualSleep
            return result
        } catch {
            alertTitle = "Ошибка"
            alertMessage = "Что-то пошло не так."
            showingAlert = true
        }
        return Date.now
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Когда вы хотите проснуться?") {
                    DatePicker("Время подъема", selection: $wakeUp,  displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                Section("Желаемое количество часов сна") {
                    Stepper("\(sleepAmount.formatted()) часов", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                
                Section("Ежедневно употребляемое количество кофе") {
                    Picker("Кофе", selection: $coffeeAmount) {
                        ForEach(0..<21) {
                            if $0 == 1 {
                                Text("\($0) чашка")
                            } else if $0 > 1 && $0 < 5 {
                                Text("\($0) чашки")
                            } else if $0 >= 5 {
                                Text("\($0) чашек")
                            }
                        }
                    }
//                    Stepper("\(coffeeAmount) шт", value: $coffeeAmount)
                    
                }
                Section("Результат") {
                    Text(bedtime.formatted(date: .omitted, time: .shortened))
                        .font(.largeTitle)
                }
                
            }
            .navigationTitle("BetterRest")
//            .toolbar {
//                Button("Вычислить", action: calculateBedtime)
//            }
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK") { }
            } message: {
                Text(alertMessage)
            }
        }
    }
//    func calculateBedtime() {
//        do {
//            let config = MLModelConfiguration()
//            let model = try SleepCalculator(configuration: config)
//            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
//            let hour = (components.hour ?? 0) * 60 * 60
//            let minute = (components.minute ?? 0) * 60
//            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
//            let sleepTime = wakeUp - prediction.actualSleep
//            alertTitle = "Время для отхода ко сну..."
//            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
//        } catch {
//            alertTitle = "Ошибка"
//            alertMessage = "Что-то пошло не так."
//        }
//        showingAlert = true
//    }
}


#Preview {
    ContentView()
}
