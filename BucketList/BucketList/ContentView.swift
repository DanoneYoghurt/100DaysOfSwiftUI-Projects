//
//  ContentView.swift
//  BucketList
//
//  Created by Антон Баскаков on 02.07.2024.
//

import MapKit
import SwiftUI

struct ContentView: View {
    
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    
    @State private var viewModel = ViewModel()
    @State private var defaultMapStyle = true
    @State private var mapStyle = MapStyle.standard
    
    
    var body: some View {
        if viewModel.isUnlocked {
            ZStack {
                MapReader { proxy in
                    Map(initialPosition: startPosition) {
                        ForEach(viewModel.locations) { location in
                            Annotation(location.name, coordinate: location.coordinate) {
                                Image(systemName: "star.circle")
                                    .resizable()
                                    .foregroundStyle(.red)
                                    .frame(width: 44, height: 44)
                                    .background(.white)
                                    .clipShape(.circle)
                                    .onLongPressGesture {
                                        viewModel.selectedPlace = location
                                    }
                            }
                        }
                    }
                    .mapStyle(mapStyle)
                    .onTapGesture { position in
                        if let coordinate = proxy.convert(position, from: .local) {
                            viewModel.addLocation(at: coordinate)
                        }
                    }
                    .sheet(item: $viewModel.selectedPlace) { place in
                        EditView(location: place) {
                            viewModel.update(location: $0)
                        }
                    }
                }
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(role: .none) {
                            toggleMapStyle()
                        } label: {
                            Image(systemName: "map")
                                .resizable()
                                .frame(width: 25, height: 25)
                        }
                        .frame(width: 60, height: 60)
                        .background(.white)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                        .padding(.vertical, 25)
                        .padding(.horizontal)
                    }
                }
            }
            
        } else {
            Button("Unlock Places", action: viewModel.authenticate)
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.capsule)
                .alert("Error", isPresented: $viewModel.showAlert) {
                } message: {
                    Text(viewModel.alertMessage)
                }
        }
            
    }
    func toggleMapStyle() {
        switch defaultMapStyle {
        case true:
            mapStyle = MapStyle.standard
        case false:
            mapStyle = MapStyle.hybrid
        }
        defaultMapStyle.toggle()
    }
}

#Preview {
    ContentView()
}
