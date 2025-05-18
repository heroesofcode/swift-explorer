//
//  FirebaseConfiguration.swift
//  Analytics
//
//  Created by João Lucas on 08/09/24.
//

import FirebaseCore
import Foundation

/// A utility for configuring Firebase in the app.
public enum FirebaseConfiguration {

    /// Initializes and configures Firebase.
    ///
    /// This method should be called once during app startup (e.g., inside the `App` or `AppDelegate`).
    public static func start() {
        FirebaseApp.configure()
    }
}
