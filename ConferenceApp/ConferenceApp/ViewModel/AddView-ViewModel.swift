//
//  AddView-ViewModel.swift
//  ConferenceApp
//
//  Created by Антон Баскаков on 13.07.2024.
//

import CoreImage
import CoreLocation
import Foundation
import PhotosUI
import SwiftUI

extension AddView {

    @Observable
    class ViewModel {
        let locationFetcher = LocationFetcher()
        
        class LocationFetcher: NSObject, CLLocationManagerDelegate {
            let manager = CLLocationManager()
            var lastKnownLocation: CLLocationCoordinate2D?

            override init() {
                super.init()
                manager.delegate = self
            }

            func start() {
                manager.requestWhenInUseAuthorization()
                manager.startUpdatingLocation()
            }

            func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
                lastKnownLocation = locations.first?.coordinate
            }
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
        
    }
    
}
