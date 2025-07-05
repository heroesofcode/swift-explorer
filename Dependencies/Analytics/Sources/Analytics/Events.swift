//
//  Events.swift
//  Analytics
//
//  Created by João Lucas on 08/09/24.
//

import Foundation

/// A namespace containing all analytics event names used throughout the app.
public enum AnalyticsEvents {

    /// Analytics events related to the Home screen.
    public enum Home: String {
        case view = "home_view"
        case button = "generate_button"
        case empty_field = "empty_field"
    }
}

/// A namespace containing all crashlytics event names used throughout the app.
public enum CrashlyticsEvents {

    /// Crashlytics events related to the Home screen.
    public enum Home: String {
        case button = "generate_button"
    }
}
