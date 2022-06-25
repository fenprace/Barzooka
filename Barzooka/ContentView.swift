//
//  ContentView.swift
//  Barzooka
//
//  Created by Zhuo FENG on 2022/6/21.
//

import SwiftUI
import SwiftEventBus

struct ContentView: View {
    @StateObject var bar = Bar()
    @StateObject var mp = MenuPool()
   
    @State var tab: Int8? = 0

    var body: some View {
        NavigationView {
            List {
                NavigationLink(tag: 0, selection: $tab, destination: {
                    MenuEditView()
                        .environmentObject(mp)
                }, label: {
                    Label("Menu", systemImage: "filemenu.and.selection")
                })
                
                NavigationLink(tag: 1, selection: $tab, destination: {
                    BarItemView()
                        .environmentObject(bar)
                }, label: {
                    Label("Status Bar", systemImage: "menubar.arrow.up.rectangle")
                })
            }.listStyle(.sidebar)
        }
        .toolbar {
            ToolbarItem {
                Button("Add") {
                    switch self.tab {
                    case 0:
                        SwiftEventBus.post("addMenu")
                    case 1:
                        SwiftEventBus.post("addBarItem")
                    default:
                        break
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
