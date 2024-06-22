//
//  Color+Utils.swift
//
//
//  Created by João Lucas on 22/06/24.
//

import SwiftUI

public extension Color {
    
    init(hex: String) {
        let scanner = Scanner(string: hex)
        
        if hex.hasPrefix("#") {
            scanner.currentIndex = hex.index(after: hex.startIndex)
        }
        
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let red = (rgbValue & 0xff0000) >> 16
        let green = (rgbValue & 0xff00) >> 8
        let blue = rgbValue & 0xff
        
        self.init(
            .sRGB,
            red: Double(red) / 0xff,
            green: Double(green) / 0xff,
            blue: Double(blue) / 0xff,
            opacity: 1
        )
    }
}
