//
//  FirebaseConfiguration.swift
//  Analytics
//
//  Created by João Lucas on 08/09/24.
//

import FirebaseCore
import Foundation

/// A utility for configuring Firebase in the app.
public final class FirebaseConfiguration {
    
    /// Prevents instantiation.
    private init() {}
    
    /// Initializes and configures Firebase.
    ///
    /// This method should be called once during app startup (e.g., inside the `App` or `AppDelegate`).
    public static func start() {
        FirebaseApp.configure()
    }
}
