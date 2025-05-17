//
//  Color+Utils.swift
//
//
//  Created by João Lucas on 22/06/24.
//

import SwiftUI

import SwiftUI

public extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "#", with: "")
        let scanner = Scanner(string: hex)
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        let r, g, b, a: Double
        if hex.count == 6 {
            r = Double((rgb & 0xFF0000) >> 16) / 255.0
            g = Double((rgb & 0x00FF00) >> 8) / 255.0
            b = Double(rgb & 0x0000FF) / 255.0
            a = 1.0
        } else if hex.count == 8 {
            r = Double((rgb & 0xFF000000) >> 24) / 255.0
            g = Double((rgb & 0x00FF0000) >> 16) / 255.0
            b = Double((rgb & 0x0000FF00) >> 8) / 255.0
            a = Double(rgb & 0x000000FF) / 255.0
        } else {
            r = 0
            g = 0
            b = 0
            a = 1.0
        }

        self.init(red: r, green: g, blue: b, opacity: a)
    }

    static let blackColor = Color(hex: "#000000")
    static let swiftColor = Color(hex: "#FA7343")
}
