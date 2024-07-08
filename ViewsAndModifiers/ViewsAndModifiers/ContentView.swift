//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Антон Баскаков on 24.04.2024.
//

import SwiftUI


struct LargeBlueTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.blue)
    }
}

extension View {
    func largeBlueTitled() -> some View {
        modifier(LargeBlueTitle())
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .largeBlueTitled()
                
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
