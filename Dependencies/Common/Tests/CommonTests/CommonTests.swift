import XCTest
@testable import Common

final class CommonTests: XCTestCase {
    
    func testAppLinksGithubURL() {
        XCTAssertEqual(AppLinks.github.rawValue, "https://github.com/heroesofcode/swift-explorer")
    }
    
    func testAppLinksLicenseURL() {
        XCTAssertEqual(AppLinks.license.rawValue, "https://github.com/heroesofcode/swift-explorer/blob/main/LICENSE")
    }
    
    func testBundleAppVersionFormat() {
        let version = Bundle.main.appVersion
        XCTAssertFalse(version.isEmpty)
        XCTAssertTrue(version.contains("("))
        XCTAssertTrue(version.contains(")"))
    }

    func testAppVersionWithMissingInfo() {
        let bundle = Bundle(for: type(of: self))
        let version = bundle.appVersion
        XCTAssertFalse(version.isEmpty)
    }
}
