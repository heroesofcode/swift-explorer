//
//  BundleExtensionTests.swift
//  Common
//
//  Created by João Lucas on 22/02/26.
//

import XCTest
@testable import Common

final class BundleExtensionTests: XCTestCase {
    
    func testAppVersionReturnsNonEmptyString() {
        let version = Bundle.main.appVersion
        XCTAssertFalse(version.isEmpty)
    }
    
    func testAppVersionFormat() {
        let version = Bundle.main.appVersion
        XCTAssertTrue(version.contains(".") || version == "Unknown")
    }
}
