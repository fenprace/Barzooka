//
//  ActionPool.swift
//  Barzooka
//
//  Created by Zhuo FENG on 2022/6/21.
//

import AppKit

class BarItemActionPool {
    static let shared = BarItemActionPool()
    
    private var actions: [NSStatusBarButton: () -> Void]
    
    init() {
        actions = [:]
    }
    
    func add(_ sender: NSStatusBarButton, action: @escaping () -> Void) {
        self.actions[sender] = action
    }
    
    @objc func act(sender: NSStatusBarButton) {
        if let action = self.actions[sender] {
            action()
        }
    }
}

class MenuItemActionPool {
    static let shared = MenuItemActionPool()
    
    private var actions: [NSMenuItem: () -> Void]
    
    init() {
        actions = [:]
    }
    
    func add(_ sender: NSMenuItem, action: @escaping () -> Void) {
        self.actions[sender] = action
    }
    
    @objc func act(sender: NSMenuItem) {
        if let action = self.actions[sender] {
            action()
        }
    }
}
