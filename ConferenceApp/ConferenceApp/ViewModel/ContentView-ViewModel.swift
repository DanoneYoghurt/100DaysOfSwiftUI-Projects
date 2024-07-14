//
//  ContentView-ViewModel.swift
//  ConferenceApp
//
//  Created by Антон Баскаков on 13.07.2024.
//

import Foundation
import PhotosUI
import SwiftUI


extension ContentView {
    
    @Observable
    class ViewModel {
        
        var model = Persons()
        
        let savePath = URL.documentsDirectory.appending(path: "SavedPersons")
        
        func removeItems(at offsets: IndexSet) {
            model.persons.remove(atOffsets: offsets)
            
            save(model)
        }
        
        func convertDataToImage(_ data: Data) -> Image {
            let converted = UIImage(data: data) ?? .broken
            let result = Image(uiImage: converted)
            return result
        }
        
        func save(_ model: Persons) {
            do {
                let data = try JSONEncoder().encode(model)
                try data.write(to: URL.documentsDirectory.appending(path: "SavedPersons"), options: .atomic)
            } catch {
                print("unable to save")
                
            }
        }
        
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                model = try JSONDecoder().decode(Persons.self, from: data)
            } catch {
                //                model = []
                print(error.localizedDescription)
            }
        }
    }
}
