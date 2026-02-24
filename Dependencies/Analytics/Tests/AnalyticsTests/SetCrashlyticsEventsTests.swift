//
//  SetCrashlyticsEventsTests.swift
//  Analytics
//
//  Created by João Lucas on 22/02/26.
//

import XCTest
@testable import Analytics

final class SetCrashlyticsEventsTests: XCTestCase {
    
    final class MockCrashlyticsLogger: CrashlyticsLogging {
        var logErrorCallsCount = 0
        var logErrorReceivedArguments: (eventName: String, params: [String: String])?
        
        func logError(eventName: String, params: [String: String]) {
            logErrorCallsCount += 1
            logErrorReceivedArguments = (eventName, params)
        }
    }
    
    var mockLogger: MockCrashlyticsLogger!
    
    override func setUp() {
        super.setUp()
        mockLogger = MockCrashlyticsLogger()
        SetCrashlyticsEvents.configureLogger(mockLogger)
    }
    
    override func tearDown() {
        mockLogger = nil
        super.tearDown()
    }
    
    func testEventWithoutParameters() {
        SetCrashlyticsEvents.event("crash_event")
        
        XCTAssertEqual(mockLogger.logErrorCallsCount, 1)
        XCTAssertEqual(mockLogger.logErrorReceivedArguments?.eventName, "crash_event")
        XCTAssertTrue(mockLogger.logErrorReceivedArguments?.params.isEmpty ?? false)
    }
    
    func testEventWithParameters() {
        let params = ["error": "test_error"]
        SetCrashlyticsEvents.event("crash_event", params: params)
        
        XCTAssertEqual(mockLogger.logErrorCallsCount, 1)
        XCTAssertEqual(mockLogger.logErrorReceivedArguments?.eventName, "crash_event")
        XCTAssertEqual(mockLogger.logErrorReceivedArguments?.params, params)
    }
}
