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
        let text = Text("Test").fontLatoBlack(size: 16)
        XCTAssertNotNil(text)
    }
    
    func testFontLatoBlackItalic() {
        let text = Text("Test").fontLatoBlackItalic(size: 16)
        XCTAssertNotNil(text)
    }
    
    func testFontLatoBold() {
        let text = Text("Test").fontLatoBold(size: 16)
        XCTAssertNotNil(text)
    }
    
    func testFontLatoBoldItalic() {
        let text = Text("Test").fontLatoBoldItalic(size: 16)
        XCTAssertNotNil(text)
    }
    
    func testFontLatoItalic() {
        let text = Text("Test").fontLatoItalic(size: 16)
        XCTAssertNotNil(text)
    }
    
    func testFontLatoLight() {
        let text = Text("Test").fontLatoLight(size: 16)
        XCTAssertNotNil(text)
    }
    
    func testFontLatoLightItalic() {
        let text = Text("Test").fontLatoLightItalic(size: 16)
        XCTAssertNotNil(text)
    }
    
    func testFontLatoRegular() {
        let text = Text("Test").fontLatoRegular(size: 16)
        XCTAssertNotNil(text)
    }
    
    func testFontLatoThin() {
        let text = Text("Test").fontLatoThin(size: 16)
        XCTAssertNotNil(text)
    }
    
    func testFontLatoThinItalic() {
        let text = Text("Test").fontLatoThinItalic(size: 16)
        XCTAssertNotNil(text)
    }
}
