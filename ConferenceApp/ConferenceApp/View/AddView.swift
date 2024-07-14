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
                    
                    
                    viewModel.convertDataToImage(photo)
                        .resizable()
                        .scaledToFit()
                    
                    TextField("Enter the name", text: $description)
                } else {
                    PhotosPicker("Pick a photo", selection: $pickerItem)
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
//                            do {
//                                let data = try JSONEncoder().encode(model.persons)
//                                try data.write(to: URL.documentsDirectory.appending(path: "message"), options: .atomic, .completeFileProtection)
//                            } catch {
//                                print("unable to save")
                            }
//                        }
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
