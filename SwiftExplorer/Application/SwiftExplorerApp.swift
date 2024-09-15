//
//  SwiftExplorerApp.swift
//  SwiftExplorer
//
//  Created by João Lucas on 22/06/24.
//

import SwiftUI
import Analytics

@main
struct SwiftExplorerApp: App {
    
    init() {
        FirebaseConfiguration.start()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
