//
//  ContentView.swift
//  Barzooka
//
//  Created by Zhuo FENG on 2022/6/21.
//

import SwiftUI

struct ContentView: View {
    @State var selectedItems: Set<BarItem> = Set()
    @StateObject var bar = Bar()
    @State var isAddOpen = false
    @State var isEditOpen = false
    
    @State var title: String = ""
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink("ABC") {
                    BarItemView()
                        .navigationTitle("BarItem")
                }
                
                NavigationLink("Menu") {
                    MenuEditView()
                        .navigationTitle("Menu")
                }
            }
            .listStyle(.sidebar)
        }
        .toolbar {
            ToolbarItem {
                Text("123")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
