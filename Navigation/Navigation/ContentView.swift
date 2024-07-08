//
//  ContentView.swift
//  Navigation
//
//  Created by Антон Баскаков on 28.05.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            
            List(0..<100) { i in
                NavigationLink("Select \(i)", value: i)
            }
            .navigationDestination(for: Int.self) { selection in
                Text("You selected \(selection)")
            }
        }
    }
}

#Preview {
    ContentView()
}
