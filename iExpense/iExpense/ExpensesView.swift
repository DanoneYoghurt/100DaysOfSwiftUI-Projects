//
//  ExpensesView.swift
//  iExpense
//
//  Created by Антон Баскаков on 19.06.2024.
//

import SwiftData
import SwiftUI

struct ExpensesView: View {
    
    @Environment(\.modelContext) var modelContext
    
    @Query var expenses: [ExpenseItem]
    
    var body: some View {
        
            ForEach(expenses) { item in
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.headline)
                        Text(NSLocalizedString(item.type, comment: ""))
                    }
                    Spacer()
                    AmountView(amount: item.amount)
                }
                .accessibilityElement(children: .ignore)
                .accessibilityLabel("\(item.name), \(NSLocalizedString(item.type, comment: ""))")
                .accessibilityHint(String(item.amount))
            }
            .onDelete(perform: removeItems)
        
    }
    init(itemType: String, sortOrder: [SortDescriptor<ExpenseItem>]) {
        _expenses = Query(filter: #Predicate<ExpenseItem> { expenseItem in
            if itemType == "All" {
                expenseItem.type == "Personal" || expenseItem.type == "Business"
            } else {
                expenseItem.type == itemType
            }
        }, sort: sortOrder)
    }
    func removeItems(at offsets: IndexSet) {
        for index in offsets {
            let item = expenses[index]
            modelContext.delete(item)
        }
    }
}

#Preview {
    ExpensesView(itemType: "Personal", sortOrder: [SortDescriptor(\ExpenseItem.name)])
        .modelContainer(for: ExpenseItem.self)
}
