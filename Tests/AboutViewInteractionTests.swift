//
//  AboutViewInteractionTests.swift
//  SwiftExplorer
//
//  Created by João Lucas on 22/02/26.
//

import XCTest
import SwiftUI
@testable import SwiftExplorer

final class AboutViewInteractionTests: XCTestCase {
    
    func testAboutViewInitialization() {
        let view = AboutView()
        XCTAssertNotNil(view)
    }
}
