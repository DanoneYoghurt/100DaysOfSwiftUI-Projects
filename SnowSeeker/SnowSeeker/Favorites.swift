//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Антон Баскаков on 31.07.2024.
//

import SwiftUI

@Observable
class Favorites {
    private var resorts: Set<String>
    
    private let key = "Favorites"
    
    init() {
        if let savedFavorites = UserDefaults.standard.data(forKey: key) {
            if let decodedFavorites = try? JSONDecoder().decode(Set<String>.self, from: savedFavorites) {
                resorts = decodedFavorites
                return
            }
        }
        print("Unable to load favorites")
        resorts = []
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        
        if let encodedFavorites = try? JSONEncoder().encode(resorts) {
            UserDefaults.standard.set(encodedFavorites, forKey: key)
            return
        }
        print("Unable to save favorites")
        
    }
}
