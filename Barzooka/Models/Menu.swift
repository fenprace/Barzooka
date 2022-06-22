//
//  Menu.swift
//  Barzooka
//
//  Created by Zhuo FENG on 2022/6/23.
//

import AppKit

class Menu: ObservableObject {
    @Published var items: [MenuItem]
    @Published var removed: [MenuItem]
    
    private(set) var instance: NSMenu? = nil
    
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
