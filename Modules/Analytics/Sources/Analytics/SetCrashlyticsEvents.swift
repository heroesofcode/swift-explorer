//
//  SetCrashlyticsEvents.swift
//  Analytics
//
//  Created by João Lucas on 04/07/25.
//

import Foundation
import FirebaseCrashlytics

public protocol CrashlyticsTracking {
    func event(_ name: String)
}

public struct DefaultCrashlyticsTracker: CrashlyticsTracking {
    public init() {}

    public func event(_ name: String) {
        let error = NSError(domain: name, code: 0, userInfo: [:])
        Crashlytics.crashlytics().record(error: error)
    }
}
