//
//  AddHabitView.swift
//  HabitTracker
//
//  Created by Антон Баскаков on 03.06.2024.
//

import SwiftUI

struct AddHabitView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var description = ""
    @State private var timesCompleted = 0
    
    var habits: Habits
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                TextField("Description", text: $description)
            }
            .navigationTitle("Add a new habit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading){
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        let item = Habit(name: name, description: description, timesCompleted: timesCompleted)
                        habits.items.append(item)
                        dismiss()
                    } label: {
                        Text("Save")
                            .bold()
                    }
                    .disabled(name.isEmpty || description.isEmpty ? true : false)
                }
        }
        
        }
    }
}

#Preview {
    AddHabitView(habits: Habits())
}
