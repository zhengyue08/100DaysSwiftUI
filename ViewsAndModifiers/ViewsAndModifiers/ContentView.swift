//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Yue ZHENG on 6/17/23.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
            .bold()
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

struct GridView<Content: View>: View {
    let rows: Int
    let columns: Int
    
    let content: (Int, Int) -> Content
    
    
    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<columns, id: \.self) { column in
                        content(row, column)
                    }
                }
            }
 
        }
    }
}

struct ContentView: View {

    var body: some View {
        VStack{
            Text("ViewsAndModifiers").titleStyle()
            GridView(rows: 3, columns: 4) {row, column in
                Text("R:\(row) C:\(column)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
