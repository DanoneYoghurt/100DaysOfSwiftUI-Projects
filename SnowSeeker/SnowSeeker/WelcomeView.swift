//
//  WelcomView.swift
//  SnowSeeker
//
//  Created by Антон Баскаков on 30.07.2024.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        Text("Welcome to SnowSeeker!")
            .font(.largeTitle)
        Text("Please select a resort from the left-hand menu; swipe from the left edge to show it.")
            .foregroundStyle(.secondary)
    }
}

#Preview {
    WelcomeView()
}
