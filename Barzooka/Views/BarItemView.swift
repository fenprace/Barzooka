//
//  BarItemView.swift
//  Barzooka
//
//  Created by Zhuo FENG on 2022/6/22.
//

import SwiftUI

struct BarItemView: View {
    @State var selectedItems: Set<BarItem> = Set()
    @StateObject var bar = Bar()
    @State var isAddOpen = false
    @State var isEditOpen = false
    
    @State var title: String = ""
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.isAddOpen = true
                }, label: {
                    Label("Add", systemImage: "plus.circle")
                })
                .popover(isPresented: $isAddOpen, arrowEdge: .bottom, content: {
                    VStack {
                        TextField("Title", text: $title)
                        
                        Button("Confirm") {
                            bar.items.append(BarItem(title: self.title))
                            bar.apply()
                            self.title = ""
                            self.isAddOpen = false
                        }
                    }
                    .padding()
                })
                
                Button(action: {
                    bar.remove(items: Array(self.selectedItems))
                    bar.apply()
                }, label: {
                    Label("Remove", systemImage: "trash")
                })
                .disabled($bar.items.isEmpty)
            }
            
            List(bar.items, id: \.self, selection: $selectedItems) { item in
                HStack {
                    Text(item.title!)

                    Spacer()

                    Button(action: {
                        self.isEditOpen = true
                    }, label: {
                        Label("Edit", systemImage: "pencil")
                    })
                    .popover(isPresented: $isEditOpen) {
                        VStack {
                            TextField("Title", text: $title)

                            Button("Confirm") {
                                item.title = title
                                bar.apply()
                                self.title = ""
                                self.isEditOpen = false
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
            .listStyle(.plain)
        }
        .padding()
    }
}

struct BarItemView_Previews: PreviewProvider {
    static var previews: some View {
        BarItemView()
    }
}
