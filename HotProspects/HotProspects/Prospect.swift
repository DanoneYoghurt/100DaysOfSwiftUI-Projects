//
//  Prospect.swift
//  HotProspects
//
//  Created by Антон Баскаков on 18.07.2024.
//

import Foundation
import SwiftData

@Model
class Prospect: Comparable {
    var name: String
    var emailAddress: String
    var isContacted: Bool
    
    init(name: String, emailAddress: String, isContacted: Bool) {
        self.name = name
        self.emailAddress = emailAddress
        self.isContacted = isContacted
    }
    
    
    static func <(lhs: Prospect, rhs: Prospect) -> Bool {
        lhs.name > rhs.name
    }
}
