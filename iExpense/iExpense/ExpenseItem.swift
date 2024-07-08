//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Антон Баскаков on 19.06.2024.
//

import Foundation
import SwiftData

@Model
class ExpenseItem {
    let name: String
    let type: String
    let amount: Double
    
    init(name: String, type: String, amount: Double) {
        self.name = name
        self.type = type
        self.amount = amount
    }
}
