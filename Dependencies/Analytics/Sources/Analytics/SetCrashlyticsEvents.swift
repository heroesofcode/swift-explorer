//
//  SetCrashlyticsEvents.swift
//  Analytics
//
//  Created by João Lucas on 04/07/25.
//

import Foundation
import FirebaseCrashlytics

/// A protocol that defines how crash events are logged.
protocol CrashlyticsLogging {
    func logError(eventName: String, params: [String: String])
}

/// The default implementation of `CrashlyticsLogging` using Firebase Crashlytics.
final class FirebaseCrashlyticsLogger: CrashlyticsLogging {
    func logError(eventName: String, params: [String: String] = [:]) {
        let error = NSError(domain: eventName, code: 0, userInfo: params)
        Crashlytics.crashlytics().record(error: error)
    }
}

/// A utility for logging crash events using a configurable logger.
///
/// By default, it uses Firebase Crashlytics, but you can inject a custom logger
/// (e.g., for testing or alternate crash reporting tools).
public enum SetCrashlyticsEvents {

    private static var logger: CrashlyticsLogging = FirebaseCrashlyticsLogger()

    /// Configures a custom logger for crash events.
    ///
    /// This method is intended for internal or testing use.
    ///
    /// - Parameter customLogger: An object conforming to `CrashlyticsLogging`.
    internal static func configureLogger(_ customLogger: CrashlyticsLogging) {
        logger = customLogger
    }

    /// Logs a crash event with the given name and no parameters.
    ///
    /// - Parameter name: The name of the crash event.
    public static func event(_ name: String) {
        logger.logError(eventName: name, params: [:])
    }

    /// Logs a crash event with the given name and parameters.
    ///
    /// - Parameters:
    ///   - name: The name of the crash event.
    ///   - params: A dictionary of additional parameters.
    public static func event(_ name: String, params: [String: String]) {
        logger.logError(eventName: name, params: params)
    }
}
