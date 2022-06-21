//
//  BarzookaApp.swift
//  Barzooka
//
//  Created by Zhuo FENG on 2022/6/21.
//

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

class AppDelegate: NSObject, NSApplicationDelegate {
    private var bar: Bar?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        print("Launched!")
        
        bar = Bar(
            BarItem(title: "Barzooka"),
            BarItem(title: "💥", action: { print("BOOM!") })
        )
    }
    
    func applicationDockMenu(_ sender: NSApplication) -> NSMenu? {
        let menu = NSMenu()
        let menuItem = NSMenuItem()
        menuItem.title = "Hello"
        menuItem.target = MenuItemActionPoll.shared
        menuItem.action = #selector(MenuItemActionPoll.shared.act)
        
        MenuItemActionPoll.shared.add(menuItem, action: {
            print("!!")
        })
        
        menu.addItem(menuItem)
        
        return menu
    }
}

@main
struct BarzookaApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .commands {
            SidebarCommands()
        }
    }
}
