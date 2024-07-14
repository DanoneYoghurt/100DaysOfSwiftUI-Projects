//
//  Model.swift
//  ConferenceApp
//
//  Created by Антон Баскаков on 13.07.2024.
//

import Foundation
import PhotosUI
import SwiftUI
import Observation

@Observable
class Persons: Codable {
    var persons = [Person]()
}

struct Person: Identifiable, Codable, Comparable {
    var id = UUID()
    var photo: Data
    var description: String
    
    static func <(lhs: Person, rhs: Person) -> Bool {
            lhs.description < rhs.description
        }
}


