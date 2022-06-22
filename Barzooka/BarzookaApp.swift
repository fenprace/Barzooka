//
//  BarzookaApp.swift
//  Barzooka
//
//  Created by Zhuo FENG on 2022/6/21.
//

import AppKit
import SwiftUI

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
        let menu = Menu(
            MenuItem(title: "Hello", subMenu: Menu(
                MenuItem(title: "!!!")
            ))
        )
        
        menu.activate()
        
        return menu.instance!
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
