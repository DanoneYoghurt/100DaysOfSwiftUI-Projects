//
//  AddView.swift
//  ConferenceApp
//
//  Created by Антон Баскаков on 13.07.2024.
//

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
                            
                            let newItem = Person(photo: photo, description: description)
                            
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
        
    }
    
}



#Preview {
    AddView(model: Persons())
}
