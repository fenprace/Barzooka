//
//  Bar.swift
//  Barzooka
//
//  Created by Zhuo FENG on 2022/6/23.
//

import Foundation


import AppKit
import SwiftUI

class Bar: ObservableObject {
    @Published var items: [BarItem]
    @Published var removed: [BarItem]
    
    init(_ items: BarItem...) {
        self.items = items
        self.removed = []
    }
    
    public func apply() {
        for item in self.items {
            item.activate()
        }
        
        for item in self.removed {
            item.deactivate()
        }
        
        self.removed = []
    }
    
    public func remove(item: BarItem) {
        self.removed.append(item)
        
        self.items.removeAll(where: { i in
            i == item
        })
    }
    
    public func remove(items: [BarItem]) {
        self.removed.append(contentsOf: items)
        
        self.items.removeAll(where: { item in
            items.contains(item)
        })
    }
    
    public func deactivate(item: BarItem?) {
        if item == nil { return }
        
        item!.deactivate()
        self.items = items.filter { i in
            return i.id != item!.id
        }
    }
    
    public func deactivate(items: [BarItem]) {
        for item in items {
            self.deactivate(item: item)
        }
    }
}
