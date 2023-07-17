//
//  ContentView.swift
//  iExpense_Structure
//
//  Created by Yue ZHENG on 2023/7/17.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

struct AddView: View {
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    @Binding var expenses: [ExpenseItem]

    @Environment(\.dismiss) var dismiss
    
    let types = ["Business", "Personal"]
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) { type in
                        Text(type)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.append(item)
                    dismiss()
                }
            }

        }
    }

}

struct ContentView: View {
    @State private var showingAddExpense = false

    @State private var expenses = [ExpenseItem]()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses) { expense in
                    Text(expense.name)
                }
                .onDelete(perform: removeItems)
            }
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: $expenses)
            }
            .navigationTitle("iExpense_Structure")
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
