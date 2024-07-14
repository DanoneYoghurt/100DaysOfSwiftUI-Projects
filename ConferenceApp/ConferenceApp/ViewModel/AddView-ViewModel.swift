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
        

        
    }
    
}
