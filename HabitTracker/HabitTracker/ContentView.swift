//
//  ContentView.swift
//  HabitTracker
//
//  Created by Антон Баскаков on 03.06.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var habits = Habits()
    
    @State var timesCompleted = 0
    
    @State private var sheetIsPresented = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Your activities here") {
                    ForEach(habits.items, id: \.id) { item in
                        NavigationLink {
                            Spacer()
                            Text(item.description)
                                .padding()
                            Spacer()
                            Text("Times completed: \(item.timesCompleted)")
                                .font(.title)
                                .padding()
                            Spacer()
                            Button("Complete activity") {
                                var newItem = item
                                newItem.timesCompleted += 1
                                if let index = habits.items.firstIndex(of: item) {
                                    habits.items[index] = newItem
                                }
                            }
                            .frame(maxWidth: 300, maxHeight: 50)
                            .background(.blue)
                            .foregroundStyle(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                            Button("Reset") {
                                var newItem = item
                                newItem.timesCompleted = 0
                                if let index = habits.items.firstIndex(of: item) {
                                    habits.items[index] = newItem
                                }
                            }
                            .frame(maxWidth: 300, maxHeight: 50)
                            .background(.red)
                            .foregroundStyle(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                            Spacer()
                        } label: {
                            HStack {
                                Text(item.name)
                                    .font(.headline)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                                Text("Count: \(item.timesCompleted)")
                                    .font(.caption)
                            }
                        }
                    }
                    .onDelete(perform: removeItems)
                }
            }
            .toolbarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        sheetIsPresented.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationTitle("Habit Tracker")
            .sheet(isPresented: $sheetIsPresented) {
                AddHabitView(habits: habits)
            }
        }
        
    }
    func removeItems(at offsets: IndexSet) {
        habits.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
