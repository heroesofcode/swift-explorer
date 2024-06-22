//
//  ColorUtilsTests.swift
//
//
//  Created by João Lucas on 22/06/24.
//

import XCTest
import SwiftUI
@testable import Theme

final class ColorUtilsTests: XCTestCase {
    
    func testColorInitWithHex() {
        let blackColor = Color(hex: "#000000")
        XCTAssertEqual(blackColor, Color(red: 0, green: 0, blue: 0, opacity: 1))
        
        let whiteColor = Color(hex: "#FFFFFF")
        XCTAssertEqual(whiteColor, Color(red: 1, green: 1, blue: 1, opacity: 1))
        
        let redColor = Color(hex: "#FF0000")
        XCTAssertEqual(redColor, Color(red: 1, green: 0, blue: 0, opacity: 1))
        
        let greenColor = Color(hex: "#00FF00")
        XCTAssertEqual(greenColor, Color(red: 0, green: 1, blue: 0, opacity: 1))
        
        let blueColor = Color(hex: "#0000FF")
        XCTAssertEqual(blueColor, Color(red: 0, green: 0, blue: 1, opacity: 1))
        
        let customColor = Color(hex: "123456")
        XCTAssertEqual(customColor, Color(red: 18/255, green: 52/255, blue: 86/255, opacity: 1))
    }
}
