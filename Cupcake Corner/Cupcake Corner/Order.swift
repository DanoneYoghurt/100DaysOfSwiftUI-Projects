//
//  Order.swift
//  Cupcake Corner
//
//  Created by Антон Баскаков on 06.06.2024.
//

import Foundation
import Observation


@Observable
class Order: Codable {
    
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = UserDefaults.standard.string(forKey: "Name") ?? ""
    var streetAddress = UserDefaults.standard.string(forKey: "Street Address") ?? ""
    var city = UserDefaults.standard.string(forKey: "City") ?? ""
    var zip = UserDefaults.standard.string(forKey: "ZIP") ?? ""
    
    var hasValidAddress: Bool {
        if name.trimmingCharacters(in: .whitespaces).isEmpty || streetAddress.trimmingCharacters(in: .whitespaces).isEmpty || city.trimmingCharacters(in: .whitespaces).isEmpty || zip.trimmingCharacters(in: .whitespaces).isEmpty {
            return false
        }
        return true
    }
    
    var cost: Decimal {
        // 2$ per cake
        var cost = Decimal(quantity) * 2
        
        // complicated cakes cost more
        cost += (Decimal(type) / 2)
        
        //1$ per cake fore extra frosting
        if extraFrosting {
            cost += Decimal(quantity)
        }
        
        //$0.50/cake for sprinkles
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }
         return cost
    }
    
}
