//
//  ContentView.swift
//  iExpense
//
//  Created by Антон Баскаков on 15.05.2024.
//

import SwiftData
import SwiftUI


struct AmountView: View {
    var amount: Double
    var color: Color {
        switch amount {
        case 0...100:
            Color.green
        case 101...1000:
            Color.orange
        case 1001...:
            Color.red
        default:
            Color.primary
        }
    }
    var body: some View {
        Text(amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
            .foregroundColor(color)
    }
}


struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    
    @Query var expenses: [ExpenseItem]
    
    @State private var showingAddExpense = false
    @State private var sortOrder = [
        SortDescriptor(\ExpenseItem.name),
        SortDescriptor(\ExpenseItem.amount)
    ]
    @State private var selectedSortingItemType = "All"
    @State private var showingConfirmation = false
    
    var body: some View {
        if expenses.isEmpty {
            NavigationStack {
                ContentUnavailableView {
                    Label("No expenses", systemImage: "list.bullet")
                } description: {
                    Text("Start by creating an expense")
                } actions: {
                    NavigationLink("Add Expense") {
                        AddView(expenses: expenses)
                    }
                    .buttonStyle(.borderedProminent)
                }
                .navigationTitle("iExpense")
            }
            
    } else {
        NavigationStack {
            List {
                ExpensesView(itemType: selectedSortingItemType, sortOrder: sortOrder)
                Section {
                    NavigationLink("Add Expense") {
                        AddView(expenses: expenses)
                    }
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showingConfirmation = true
                    } label: {
                        Image(systemName: "trash")
                            .foregroundStyle(.red)
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Menu("Sort", systemImage: "arrow.up.arrow.down"){
                        Picker("Sort", selection: $sortOrder){
                            Text("Sort by Name")
                                .tag([
                                    SortDescriptor(\ExpenseItem.name),
                                    SortDescriptor(\ExpenseItem.amount)
                                ])
                            Text("Sort by Amount")
                                .tag([
                                    SortDescriptor(\ExpenseItem.amount),
                                    SortDescriptor(\ExpenseItem.name)
                                ])
                        }
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Menu("Filter", systemImage: "line.3.horizontal.decrease.circle") {
                        Picker("Filter", selection: $selectedSortingItemType) {
                            Text("Show All")
                                .tag("All")
                            Text("Filter by Personal")
                                .tag("Personal")
                            Text("Filter by Business")
                                .tag("Business")
                        }
                    }
                }
            }
        }
        .alert("Delete all items?", isPresented: $showingConfirmation) {
            Button("Delete", role: .destructive) {
                deleteAll()
            }
        } message: {
            Text("This action cannot be undone")
        }
    }
    }
    func deleteAll() {
        for expense in expenses {
            modelContext.delete(expense)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: ExpenseItem.self)
}
