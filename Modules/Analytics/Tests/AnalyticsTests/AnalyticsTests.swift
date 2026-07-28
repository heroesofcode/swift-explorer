import XCTest
@testable import Analytics

final class AnalyticsTests: XCTestCase {

    func testAnalyticsEventsHomeRawValues() {
        XCTAssertEqual(AnalyticsEvents.Home.view.rawValue, "home_view")
        XCTAssertEqual(AnalyticsEvents.Home.button.rawValue, "generate_button")
        XCTAssertEqual(AnalyticsEvents.Home.emptyField.rawValue, "empty_field")
    }

    func testCrashlyticsEventsHomeRawValues() {
        XCTAssertEqual(CrashlyticsEvents.Home.button.rawValue, "generate_button")
    }
}
