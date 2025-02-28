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
    
    @StateObject var coordinator: MainCoordinatorViewModel
    
    init() {
        self._coordinator = StateObject(wrappedValue: MainCoordinatorViewModel())
        FirebaseConfiguration.start()
    }
    
    var body: some Scene {
        WindowGroup {
            MainCoordinatorView(viewModel: coordinator)
        }
    }
}
