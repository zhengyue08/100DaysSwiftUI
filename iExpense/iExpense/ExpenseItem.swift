//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Yue ZHENG on 2023/7/16.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
