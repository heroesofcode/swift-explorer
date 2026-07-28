//
//  Color+Theme.swift
//  DesignSystem
//
//  Created by João Lucas on 08/03/26.
//

import SwiftUI

public extension Color {

    /// Creates a Color from a hex string (e.g. "#000000", "FF0000").
    /// Supports 6-digit RGB and optional leading "#".
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let red = Double((int >> 16) & 0xFF) / 255
        let green = Double((int >> 8) & 0xFF) / 255
        let blue = Double(int & 0xFF) / 255
        self.init(red: red, green: green, blue: blue)
    }

    /// #000000
    static let themeBlack = Color(hex: "#000000")

    /// #FA7343
    static let themeSwift = Color(hex: "#FA7343")

    /// #FFFFFF
    static let themeWhite = Color(hex: "#FFFFFF")

    /// #EBEBF5
    static let themeGrayClear = Color(hex: "#EBEBF5")

    /// #F5F5F5
    static let themeControlBackground = Color(hex: "#F5F5F5")

    /// #C8C8C8
    static let themeSeparator = Color(hex: "#C8C8C8")
}
