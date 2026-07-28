//
//  SetAnalyticsEvents.swift
//  Analytics
//
//  Created by João Lucas on 08/09/24.
//

import Foundation
import FirebaseAnalytics

/// Protocol defining the interface for tracking analytics events.
public protocol AnalyticsTracking {
    /// Logs an analytics event with the given name.
    func event(_ name: String)
}

/// Default implementation of `AnalyticsTracking` backed by Firebase Analytics.
public struct DefaultAnalyticsTracker: AnalyticsTracking {

    public init() {}

    /// Logs an event to Firebase Analytics with the given name and no additional parameters.
    public func event(_ name: String) {
        Analytics.logEvent(name, parameters: nil)
    }
}
