//
//  DetailView.swift
//  ConferenceApp
//
//  Created by Антон Баскаков on 13.07.2024.
//

import SwiftUI

struct DetailView: View {
    
    var photo: Image
    var description: String
    
    var body: some View {
        NavigationStack {
            ScrollView {
                photo
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                    .shadow(radius: 10)
                    .padding()
                Text(description)
                    .padding(.top, 7)
                    .fontWeight(.bold)
                    .font(.title2)
            }
            .navigationTitle("Details")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

#Preview {
    DetailView(photo: Image(.example), description: "Anton Baskakov")
}
