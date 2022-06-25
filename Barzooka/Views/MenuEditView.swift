//
//  MenuEditView.swift
//  Barzooka
//
//  Created by Zhuo FENG on 2022/6/23.
//

import SwiftUI
import SwiftEventBus

class MenuPool: ObservableObject {
    @Published var menus: [Menu] = []
    @Published var menuItems: [MenuItem] = []
}

struct MenuEditView: View {
    @EnvironmentObject var mp: MenuPool
    @State var name = ""
    @State var isAddOpen = false
    
    func openAdd() {
        self.isAddOpen = true
    }
    
    func confimAdd() {
        mp.menus.append(Menu(name: self.name))
        self.name = ""
        self.isAddOpen = false
    }
    
    var body: some View {
        VStack {
            List {
                ForEach($mp.menus) { $menu in
                    Text(menu.name)
                }
            }
        }
        .sheet(isPresented: $isAddOpen) {
            VStack {
                TextField("Name", text: $name)
                Button("Confirm", action: confimAdd)
            }
            .padding()
        }
        .onAppear {
            SwiftEventBus.onMainThread(EventPool.shared, name: "addMenu") { result in
                self.openAdd()
            }
        }
        .onDisappear {
            SwiftEventBus.unregister(EventPool.shared, name: "addMenu")
        }
    }
}

struct MenuEditView_Previews: PreviewProvider {
    static var previews: some View {
        MenuEditView()
    }
}
