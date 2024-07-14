//
//  DetailView.swift
//  ConferenceApp
//
//  Created by Антон Баскаков on 13.07.2024.
//

import SwiftUI
import MapKit

struct DetailView: View {
    
    var photo: Image
    var description: String
    var latitude: Double
    var longitude: Double
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Text(description)
                    .padding(.top, 10)
                    .fontWeight(.bold)
                    .font(.title2)
                
                photo
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                    .shadow(radius: 10)
                    .padding()
                
                Text("Picture location")
                    .padding(.top, 5)
                    .fontWeight(.semibold)
                    .font(.title3)
                
                Map(interactionModes: [.zoom, .pan]) {
                    let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                    
                    Marker("", systemImage: "camera", coordinate: coordinate)
                    
                }
                .frame(height: 350)
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                .shadow(radius: 10)
                .padding(.horizontal)
            }
            .navigationTitle("Details")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

#Preview {
    DetailView(photo: Image(.example), description: "Anton Baskakov", latitude: 55.751999, longitude: 37.617734)
}
