//
//  ContentView.swift
//  AccesibilitySandbox
//
//  Created by Антон Баскаков on 08.07.2024.
//

import SwiftUI

struct ContentView: View {
  @State private var value = 10
    
    var body: some View {
        VStack {
            Text("Value: \(value)")
            
            Button("increment") {
                value += 1
            }
            Button("decrement") {
                value -= 1
            }
        }
        .accessibilityElement()
        .accessibilityLabel("Value")
        .accessibilityValue(String(value))
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .increment:
                value += 1
            case .decrement:
                value -= 1
            default:
                print("Not handled")
            }
        }
    }
}

#Preview {
    ContentView()
}
