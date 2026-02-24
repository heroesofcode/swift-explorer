//
//  SwiftExplorerAppTests.swift
//  SwiftExplorer
//
//  Created by João Lucas on 22/02/26.
//

import XCTest
@testable import SwiftExplorer

final class SwiftExplorerAppTests: XCTestCase {
    
    func testAppInitialization() {
        let app = SwiftExplorerApp()
        XCTAssertNotNil(app)
    }
}
