//
//  BarItem.swift
//  Barzooka
//
//  Created by Zhuo FENG on 2022/6/21.
//

import AppKit

class BarItem: Identifiable, Hashable {
    let id = UUID()
    
    static func == (lhs: BarItem, rhs: BarItem) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }

    
    private var instance: NSStatusItem? = nil
    var title: String? = nil
    var action: (() -> Void)? = nil
    var length = NSStatusItem.variableLength
    
    var isActive:Bool {
        get { return self.instance != nil }
    }
    
    public func activate() {
        let instance = self.instance == nil
            ? NSStatusBar.system.statusItem(withLength: self.length)
            : self.instance!
        
        if let title = self.title {
            instance.button?.title = title
        }
        
        if let action = self.action {
            BarItemActionPool.shared.add(instance.button!, action: action)
            instance.button?.target = BarItemActionPool.shared
            instance.button?.action = #selector(BarItemActionPool.shared.act)
        }
        
        self.instance = instance
    }
    
    public func deactivate() {
        self.instance = nil
        
    }
    
    init(title: String, action: @escaping (() -> Void)) {
        self.title = title
        self.action = action
    }
    
    init(title: String) {
        self.title = title
    }
}
