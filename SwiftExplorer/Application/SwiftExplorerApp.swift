//
//  SwiftExplorerApp.swift
//  SwiftExplorer
//
//  Created by João Lucas on 22/06/24.
//

import SwiftUI
import Analytics
import Common

@main
struct SwiftExplorerApp: App {

    init() {
        FirebaseConfiguration.start()
    }

    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .commands {
            CommandGroup(replacing: .appInfo) {
                Button("About SwiftExplorer") {
                    showAboutWindow()
                }
            }
        }
    }

    private func showAboutWindow() {
        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 200, height: 100),
            styleMask: [.titled, .closable],
            backing: .buffered,
            defer: false
        )
        window.center()
        window.title = "About Swift Explorer"
        window.isReleasedWhenClosed = false
        window.contentView = NSHostingView(rootView: AboutView())
        window.makeKeyAndOrderFront(nil)
    }
}
