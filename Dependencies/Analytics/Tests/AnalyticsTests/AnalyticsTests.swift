import XCTest
@testable import Analytics

final class AnalyticsTests: XCTestCase {

    func testLogEventWithoutParameters() {
        let mockLogger = MockAnalyticsLogger()
        SetAnalyticsEvents.configureLogger(mockLogger)

        SetAnalyticsEvents.event("test_event")

        XCTAssertEqual(mockLogger.loggedEvents.count, 1)
        XCTAssertEqual(mockLogger.loggedEvents.first?.name, "test_event")
        XCTAssertNil(mockLogger.loggedEvents.first?.parameters)
    }

    func testLogEventWithParameters() {
        let mockLogger = MockAnalyticsLogger()
        SetAnalyticsEvents.configureLogger(mockLogger)

        let parameters = ["key": "value"]
        SetAnalyticsEvents.event("test_event", parameters: parameters)

        XCTAssertEqual(mockLogger.loggedEvents.count, 1)
        XCTAssertEqual(mockLogger.loggedEvents.first?.name, "test_event")
        XCTAssertEqual(mockLogger.loggedEvents.first?.parameters as? [String: String], parameters)
    }
    
    func testAnalyticsEventsHomeRawValues() {
        XCTAssertEqual(AnalyticsEvents.Home.view.rawValue, "home_view")
        XCTAssertEqual(AnalyticsEvents.Home.button.rawValue, "generate_button")
        XCTAssertEqual(AnalyticsEvents.Home.emptyField.rawValue, "empty_field")
    }
    
    func testCrashlyticsEventsHomeRawValues() {
        XCTAssertEqual(CrashlyticsEvents.Home.button.rawValue, "generate_button")
    }
}

    func testMultipleEventLogging() {
        let mockLogger = MockAnalyticsLogger()
        SetAnalyticsEvents.configureLogger(mockLogger)
        
        SetAnalyticsEvents.event("event1")
        SetAnalyticsEvents.event("event2")
        SetAnalyticsEvents.event("event3", parameters: ["key": "value"])
        
        XCTAssertEqual(mockLogger.loggedEvents.count, 3)
    }
