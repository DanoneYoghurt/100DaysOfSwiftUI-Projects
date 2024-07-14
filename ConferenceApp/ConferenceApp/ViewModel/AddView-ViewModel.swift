//
//  AddView-ViewModel.swift
//  ConferenceApp
//
//  Created by Антон Баскаков on 13.07.2024.
//

import CoreImage
import Foundation
import PhotosUI
import SwiftUI

extension AddView {

    @Observable
    class ViewModel {
        
        
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
        
    }
    
}
