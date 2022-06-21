//
//  BarzookaApp.swift
//  Barzooka
//
//  Created by Zhuo FENG on 2022/6/21.
//

import AppKit
import SwiftUI

class Pref: ObservableObject {
    @Published var bar = Bar()
    
    static let shared = Pref()
}

class Bar: ObservableObject {
    @Published var items: [BarItem]
    
    init(_ items: BarItem...) {
        self.items = items
    }
    
    public func activate() {
        for item in items {
            item.activate()
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
        Settings {
            ContentView()
        }
    }
}
