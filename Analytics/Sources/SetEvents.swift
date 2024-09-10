//
//  SetEvents.swift
//  Analytics
//
//  Created by João Lucas on 08/09/24.
//

import FirebaseAnalytics
import Foundation

protocol AnalyticsLogging {
    func logEvent(_ name: String, parameters: [String: Any]?)
}

final class FirebaseAnalyticsLogger: AnalyticsLogging {
    func logEvent(_ name: String, parameters: [String: Any]?) {
        Analytics.logEvent(name, parameters: parameters)
    }
}

public enum SetAnalyticsEvents {

    private static var logger: AnalyticsLogging = FirebaseAnalyticsLogger()

    internal static func configureLogger(_ customLogger: AnalyticsLogging) {
        logger = customLogger
    }

    public static func event(_ name: String) {
        logger.logEvent(name, parameters: nil)
    }

    public static func event(_ name: String, parameters: [String: Any]?) {
        logger.logEvent(name, parameters: parameters)
    }
}
