//
//  ContentView.swift
//  iExpense
//
//  Created by Yue ZHENG on 2023/7/14.
//

import SwiftUI



struct ContentView: View {
    
    @State private var showingAddExpense = false
    
    @StateObject var expenses = Expenses()
    
    let currencyType = FloatingPointFormatStyle<Double>.Currency.currency(code: Locale.current.currency?.identifier ?? "USD")

    var body: some View {
        NavigationStack {
            List{
                Section{
                    ForEach(expenses.items){ item in
                        
                        if item.type == "Personal"{
                            HStack{
                                VStack{
                                    Text(item.name)
                                        .font(.title)
                                        .foregroundColor(item.amount > 10 ? item.amount > 100 ? .red: .blue : .black)
                                    Text(item.type)
                                }
                                Spacer()
                                VStack {
                                    Text(item.amount, format: currencyType)
                                }
                            }
                        }
                        
                    }
                    .onDelete(perform: removeItems)
                } header: {
                    Text("Personal")
                }
                Section {
                    ForEach(expenses.items){ item in
                        
                        if (item.type == "Business"){
                            HStack{
                                VStack{
                                    Text(item.name)
                                        .font(.title)
                                        .foregroundColor(item.amount > 10 ? item.amount > 100 ? .red: .blue : .black)
                                    Text(item.type)
                                }
                                Spacer()
                                VStack {
                                    Text(item.amount, format: currencyType)
                                }
                            }
                        }

                    }
                    .onDelete(perform: removeItems)
                } header: {
                    Text ("Business")
                }
                
            }
            .navigationTitle("iExpenses")
            .toolbar {
                Button {
//                    let expense = ExpenseItem(name: "Test", type: "Personal", amount: 5)
                    showingAddExpense = true
//                    expenses.items.append(expense)
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }

        }
       
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
