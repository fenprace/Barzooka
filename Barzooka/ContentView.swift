//
//  ContentView.swift
//  Barzooka
//
//  Created by Zhuo FENG on 2022/6/21.
//

import SwiftUI

struct ContentView: View {
    @State var items: [BarItem] = []
    @StateObject var bar = Bar()
    
    var body: some View {
        VStack {
            Button("+") {
                bar.items.append(BarItem(title: "Hello!"))
            }
            
            Button("Active") {
                bar.activate()
            }
            
            List(bar.items) { item in
                Text(item.title!)
            }
            .listStyle(.sidebar)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
