//
//  MenuItem.swift
//  Barzooka
//
//  Created by Zhuo FENG on 2022/6/22.
//

import AppKit

class MenuItem: Identifiable, Hashable {
    let id = UUID()
    
    static func == (lhs: MenuItem, rhs: MenuItem) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
    private(set) var instance: NSMenuItem? = nil
    
    var title: String? = nil
    var action: (() -> Void)? = nil
    var subMenu: Menu? = nil
    var isSeparator: Bool = false
    
    var isActive: Bool {
        get { return self.instance != nil }
    }
    
    public func activate() {
        var instance: NSMenuItem
        
        if self.isSeparator {
            instance = NSMenuItem.separator()
        } else {
            instance = self.instance ?? NSMenuItem()
        }
        
        if let title = self.title {
            instance.title = title
        }
        
        if let action = self.action {
            MenuItemActionPool.shared.add(instance, action: action)
            instance.target = MenuItemActionPool.shared
            instance.action = #selector(MenuItemActionPool.shared.act)
        }
        
        if let subMenu = self.subMenu {
            subMenu.activate()
            instance.submenu = subMenu.instance!
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
    
    init(title: String, subMenu: Menu) {
        self.title = title
        self.subMenu = subMenu
    }
    
    init(title: String) {
        self.title = title
    }
    
    init(isSeparator: Bool) {
        self.isSeparator = isSeparator
    }
}

