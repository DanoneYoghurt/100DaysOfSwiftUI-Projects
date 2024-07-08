//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Антон Баскаков on 15.05.2024.
//

import SwiftData
import SwiftUI

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ExpenseItem.self)
    }
}
