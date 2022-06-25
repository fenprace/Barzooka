//
//  Menu.swift
//  Barzooka
//
//  Created by Zhuo FENG on 2022/6/23.
//

import AppKit

class Menu: Identifiable, ObservableObject {
    @Published var items: [MenuItem]
    @Published var removed: [MenuItem]
    @Published var name: String = ""
    
    let id = UUID()
    
    private(set) var instance: NSMenu? = nil
    
    init(name: String) {
        self.name = name
        self.items = []
        self.removed = []
    }
    
    init(_ items: MenuItem...) {
        self.items = items
        self.removed = []
    }
    
    var isActive: Bool {
        get { return self.instance != nil }
    }
    
    func activate() {
        let instance = self.instance == nil
        ? NSMenu()
        : self.instance!
        
        for item in self.items {
            item.activate()
            instance.addItem(item.instance!)
        }
        
        self.instance = instance
    }
}
