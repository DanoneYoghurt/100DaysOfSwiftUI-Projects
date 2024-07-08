//
//  AstronautView.swift
//  Moonshot
//
//  Created by Антон Баскаков on 24.05.2024.
//

import SwiftUI

struct AstronautView: View {
    
    let astonaut: Astronaut
    
    var body: some View {
        ScrollView {
            VStack {
                Image(astonaut.id)
                    .resizable()
                    .scaledToFit()
                Text(astonaut.description)
                    .padding()
            }
            
        }
        .background(.darkBackground)
        .navigationTitle(astonaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    return AstronautView(astonaut: astronauts["aldrin"]!)
        .preferredColorScheme(.dark)
}
