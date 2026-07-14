//
//  TextFontsTests.swift
//  DesignSystem
//
//  Created by João Lucas on 22/02/26.
//

import XCTest
import SwiftUI
@testable import DesignSystem

final class TextFontsTests: XCTestCase {

    func testFontLatoBlack() {
        let font = SwiftUI.Font.latoBlack(size: 16)
        XCTAssertNotNil(font)
    }

    func testFontLatoBlackItalic() {
        let font = SwiftUI.Font.latoBlackItalic(size: 16)
        XCTAssertNotNil(font)
    }

    func testFontLatoBold() {
        let font = SwiftUI.Font.latoBold(size: 16)
        XCTAssertNotNil(font)
    }

    func testFontLatoBoldItalic() {
        let font = SwiftUI.Font.latoBoldItalic(size: 16)
        XCTAssertNotNil(font)
    }

    func testFontLatoItalic() {
        let font = SwiftUI.Font.latoItalic(size: 16)
        XCTAssertNotNil(font)
    }

    func testFontLatoLight() {
        let font = SwiftUI.Font.latoLight(size: 16)
        XCTAssertNotNil(font)
    }

    func testFontLatoLightItalic() {
        let font = SwiftUI.Font.latoLightItalic(size: 16)
        XCTAssertNotNil(font)
    }

    func testFontLatoRegular() {
        let font = SwiftUI.Font.latoRegular(size: 16)
        XCTAssertNotNil(font)
    }

    func testFontLatoThin() {
        let font = SwiftUI.Font.latoThin(size: 16)
        XCTAssertNotNil(font)
    }

    func testFontLatoThinItalic() {
        let font = SwiftUI.Font.latoThinItalic(size: 16)
        XCTAssertNotNil(font)
    }
}
