//
//  SetAnalyticsEvents.swift
//  Analytics
//
//  Created by João Lucas on 08/09/24.
//

import Foundation
import FirebaseAnalytics

/// A protocol that defines how analytics events are logged.
protocol AnalyticsLogging {
    func logEvent(_ name: String, parameters: [String: Any]?)
}

/// The default implementation of `AnalyticsLogging` using Firebase Analytics.
final class FirebaseAnalyticsLogger: AnalyticsLogging {
    func logEvent(_ name: String, parameters: [String: Any]?) {
        Analytics.logEvent(name, parameters: parameters)
    }
}

/// A utility for logging analytics events using a configurable logger.
///
/// By default, it uses Firebase Analytics, but you can inject a custom logger
/// (e.g., for testing or alternate analytics providers).
public enum SetAnalyticsEvents {

    private static var logger: AnalyticsLogging = FirebaseAnalyticsLogger()

    /// Configures a custom logger for analytics events.
    ///
    /// This method is intended for internal or testing use.
    ///
    /// - Parameter customLogger: An object conforming to `AnalyticsLogging`.
    internal static func configureLogger(_ customLogger: AnalyticsLogging) {
        logger = customLogger
    }

    /// Logs an analytics event with the given name and no parameters.
    ///
    /// - Parameter name: The name of the event to log.
    public static func event(_ name: String) {
        logger.logEvent(name, parameters: nil)
    }

    /// Logs an analytics event with the given name and parameters.
    ///
    /// - Parameters:
    ///   - name: The name of the event to log.
    ///   - parameters: A dictionary of parameters to include with the event.
    public static func event(_ name: String, parameters: [String: Any]?) {
        logger.logEvent(name, parameters: parameters)
    }
}
