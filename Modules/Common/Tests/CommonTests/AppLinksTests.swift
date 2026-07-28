//
//  AppLinksTests.swift
//  Common
//
//  Created by João Lucas on 22/02/26.
//

import XCTest
@testable import Common

final class AppLinksTests: XCTestCase {
    
    func testGithubLinkIsValid() {
        let url = URL(string: AppLinks.github.rawValue)
        XCTAssertNotNil(url)
        XCTAssertTrue(AppLinks.github.rawValue.contains("github.com"))
    }
    
    func testLicenseLinkIsValid() {
        let url = URL(string: AppLinks.license.rawValue)
        XCTAssertNotNil(url)
        XCTAssertTrue(AppLinks.license.rawValue.contains("github.com"))
    }
}
