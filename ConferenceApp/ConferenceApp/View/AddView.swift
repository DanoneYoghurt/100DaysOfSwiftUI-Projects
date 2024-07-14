//
//  AddView.swift
//  ConferenceApp
//
//  Created by Антон Баскаков on 13.07.2024.
//

import CoreLocation
import PhotosUI
import SwiftUI



struct AddView: View {
    
    
    
    @Environment(\.dismiss) var dismiss
    
    var model: Persons
    
    var viewModel = ViewModel()
    
    @State private var pickerItem: PhotosPickerItem?
    @State private var photo: Data?
    @State private var description = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                if let photo = photo {
                    
                    ScrollView {
                        viewModel.convertDataToImage(photo)
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 25.0))
                            .shadow(radius: 10)
                            .padding()
                        
                        
                        TextField("Enter the name", text: $description)
                            .textFieldStyle(.roundedBorder)
                            .padding(.horizontal)
                    }
                    
                } else {
                    PhotosPicker("Pick a photo", selection: $pickerItem, matching: .images)
                }
            }
            .onChange(of: pickerItem) {
                Task {
                    photo = try await pickerItem?.loadTransferable(type: Data.self)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        if let photo = photo {
//                            viewModel.locationFetcher.start()
                            
                            let coordinate = viewModel.locationFetcher.lastKnownLocation ?? CLLocationCoordinate2D(latitude: 54.1961, longitude: 37.6182)
                            
                            let latitude = Double(coordinate.latitude)
                            let longitude = Double(coordinate.longitude)
                            
                            
                            let newItem = Person(photo: photo, description: description, latitude: latitude, longitude: longitude)
                            
                            model.persons.append(newItem)
                            
                            viewModel.save(model)
                        }
                        dismiss()
                    }
                    .disabled(photo == nil)
                    .bold()
                }
            }
        }
        .onAppear {
            viewModel.locationFetcher.start()
        }
        
    }
    
}



#Preview {
    AddView(model: Persons())
}
