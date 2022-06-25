//
//  BarItemView.swift
//  Barzooka
//
//  Created by Zhuo FENG on 2022/6/22.
//

import SwiftUI
import SwiftEventBus

struct BarItemView: View {
    @EnvironmentObject var bar: Bar
    
    @State var selectedItems: Set<BarItem> = Set()
    @State var isAddOpen = false
    @State var isEditOpen = false
    @State var title: String = ""
    
    func openAdd() {
        self.isAddOpen = true
    }
    
    func dismissAdd() {
        self.isAddOpen = false
        self.title = ""
    }
    
    func confirmAdd() {
        guard !self.title.isEmpty else { return }
        self.bar.items.append(BarItem(title: self.title))
        self.bar.apply()
        self.title = ""
        self.isAddOpen = false
    }
    
    func openEdit(_ item: BarItem) {
        self.title = item.title ?? ""
        self.isEditOpen = true
    }
    
    func dismissEdit() {
        self.isEditOpen = false
    }
    
    func confirmRemoveSingle(_ item: BarItem) {
        item.title = self.title
        self.bar.apply()
        self.title = ""
        self.isEditOpen = false
    }
    
    func handleRemove() {
        self.bar.remove(items: Array(self.selectedItems))
        self.bar.apply()
    }
    
    var body: some View {
        VStack {
            List() {
                ForEach(bar.items, id: \.self) { item in
                    HStack {
                        Text(item.title!)
                        Spacer()
                        Button(action: {
                            openEdit(item)
                        }, label: {
                            Label("Edit", systemImage: "pencil")
                        })
                        .sheet(isPresented: $isEditOpen) {
                            VStack {
                                TextField("Title", text: $title)
                                Button("Confirm") {
                                    confirmRemoveSingle(item)
                                }
                            }
                            .padding()
                        }
                        
                        Button(action: {
                            bar.remove(item: item)
                            bar.apply()
                        }, label: {
                            Label("Remove", systemImage: "trash")
                        })
                    }
                }
            }
        }
        .sheet(isPresented: $isAddOpen) {
            VStack {
                TextField("Title", text: $title)
                Button("Confirm", action: confirmAdd)
            }
            .onExitCommand(perform: dismissAdd)
            .padding()
        }
        .onAppear {
            SwiftEventBus.onMainThread(EventPool.shared, name: "addBarItem") { result in
                self.openAdd()
            }
        }
        .onDisappear {
            SwiftEventBus.unregister(EventPool.shared, name: "addBarItem")
        }
    }
}

struct BarItemView_Previews: PreviewProvider {
    static var previews: some View {
        BarItemView()
    }
}
