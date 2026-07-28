//
//  Font+Fonts.swift
//  DesignSystem
//
//  Created by João Lucas on 21/08/24.
//

import SwiftUI

/// Extension that adds Lato font styles to SwiftUI's `Font`.
public extension SwiftUI.Font {

    static func latoBlack(size: CGFloat) -> SwiftUI.Font {
        SwiftUI.Font.custom(FontFamily.Lato.black, size: size)
    }

    static func latoBlackItalic(size: CGFloat) -> SwiftUI.Font {
        SwiftUI.Font.custom(FontFamily.Lato.blackItalic, size: size)
    }

    static func latoBold(size: CGFloat) -> SwiftUI.Font {
        SwiftUI.Font.custom(FontFamily.Lato.bold, size: size)
    }

    static func latoBoldItalic(size: CGFloat) -> SwiftUI.Font {
        SwiftUI.Font.custom(FontFamily.Lato.boldItalic, size: size)
    }

    static func latoItalic(size: CGFloat) -> SwiftUI.Font {
        SwiftUI.Font.custom(FontFamily.Lato.italic, size: size)
    }

    static func latoLight(size: CGFloat) -> SwiftUI.Font {
        SwiftUI.Font.custom(FontFamily.Lato.light, size: size)
    }

    static func latoLightItalic(size: CGFloat) -> SwiftUI.Font {
        SwiftUI.Font.custom(FontFamily.Lato.lightItalic, size: size)
    }

    static func latoRegular(size: CGFloat) -> SwiftUI.Font {
        SwiftUI.Font.custom(FontFamily.Lato.regular, size: size)
    }

    static func latoThin(size: CGFloat) -> SwiftUI.Font {
        SwiftUI.Font.custom(FontFamily.Lato.hairline, size: size)
    }

    static func latoThinItalic(size: CGFloat) -> SwiftUI.Font {
        SwiftUI.Font.custom(FontFamily.Lato.hairlineItalic, size: size)
    }
}
