//
//  AnalyticsLoggerMock.swift
//  Analytics
//
//  Created by João Lucas on 09/09/24.
//

import Foundation

final class MockAnalyticsLogger: AnalyticsLogging {

    var loggedEvents: [(name: String, parameters: [String: Any]?)] = []

    func logEvent(_ name: String, parameters: [String: Any]?) {
        loggedEvents.append((name: name, parameters: parameters))
    }
}
