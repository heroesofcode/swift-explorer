//
//  SetEvents.swift
//  Analytics
//
//  Created by João Lucas on 08/09/24.
//

import FirebaseAnalytics
import Foundation

public enum SetAnalyticsEvents {

    public static func event(_ name: String) {
        Analytics.logEvent(name, parameters: nil)
    }

    public static func event(_ name: String, parameters: [String: Any]?) {
        Analytics.logEvent(name, parameters: parameters)
    }
}
