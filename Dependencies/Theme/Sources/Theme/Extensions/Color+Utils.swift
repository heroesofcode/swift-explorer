//
//  Color+Utils.swift
//
//
//  Created by João Lucas on 22/06/24.
//

import SwiftUI

/// Extension for creating custom `Color` values from hexadecimal strings and defining common color constants.
///
/// Provides a convenient initializer to create `Color` using hex values (with or without alpha),
/// and includes predefined colors for consistent usage across the app.
public extension Color {
    
    init(hex: String) {
        let hex = hex
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "#", with: "")

        let scanner = Scanner(string: hex)
        var hexValue: UInt64 = 0
        scanner.scanHexInt64(&hexValue)
        
        let redValue, greenValue, blueValue, alphaValue: Double
        
        if hex.count == 6 {
            redValue = Double((hexValue & 0xFF0000) >> 16) / 255.0
            greenValue = Double((hexValue & 0x00FF00) >> 8) / 255.0
            blueValue = Double(hexValue & 0x0000FF) / 255.0
            alphaValue = 1.0
        } else if hex.count == 8 {
            redValue = Double((hexValue & 0xFF000000) >> 24) / 255.0
            greenValue = Double((hexValue & 0x00FF0000) >> 16) / 255.0
            blueValue = Double((hexValue & 0x0000FF00) >> 8) / 255.0
            alphaValue = Double(hexValue & 0x000000FF) / 255.0
        } else {
            redValue = 0
            greenValue = 0
            blueValue = 0
            alphaValue = 1.0
        }
        
        self.init(red: redValue, green: greenValue, blue: blueValue, opacity: alphaValue)
    }
    
    static let whiteColor = Color(hex: "#FFFFFF")
    static let blackColor = Color(hex: "#000000")
    static let swiftColor = Color(hex: "#FA7343")
    static let grayColor = Color(hex: "#EBEBF599")
}
