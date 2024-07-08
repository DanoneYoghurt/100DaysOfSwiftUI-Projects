//
//  Habits.swift
//  HabitTracker
//
//  Created by Антон Баскаков on 03.06.2024.
//

import Foundation
import Observation

struct Habit: Identifiable, Codable, Equatable {
    var id = UUID()
    let name: String
    let description: String
    var timesCompleted = 0
}

@Observable
class Habits {
    
    var items = [Habit]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Habits")
            }
        }
    }
    
    init() {
        if let savedHabits = UserDefaults.standard.data(forKey: "Habits") {
            if let decodedHabits = try? JSONDecoder().decode([Habit].self, from: savedHabits) {
                items = decodedHabits
                return
            }
        }
        items = []
    }
}
