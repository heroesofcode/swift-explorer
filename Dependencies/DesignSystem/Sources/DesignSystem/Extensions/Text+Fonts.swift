//
//  Text+Fonts.swift
//
//
//  Created by João Lucas on 21/08/24.
//

import SwiftUI

/// Extension that adds convenient Lato font styling methods to `Text`.
///
/// Each method applies a different Lato font style (e.g. Black, Bold, Italic) with the given size,
/// allowing for consistent and reusable typography across the app.
public extension Text {

    func fontLatoBlack(size: CGFloat) -> Text {
        return self.font(.custom(FontFamily.Lato.black, size: size))
    }
    
    func fontLatoBlackItalic(size: CGFloat) -> Text {
        return self.font(.custom(FontFamily.Lato.blackItalic, size: size))
    }
    
    func fontLatoBold(size: CGFloat) -> Text {
        return self.font(.custom(FontFamily.Lato.bold, size: size))
    }
    
    func fontLatoBoldItalic(size: CGFloat) -> Text {
        return self.font(.custom(FontFamily.Lato.boldItalic, size: size))
    }
    
    func fontLatoItalic(size: CGFloat) -> Text {
        return self.font(.custom(FontFamily.Lato.italic, size: size))
    }
    
    func fontLatoLight(size: CGFloat) -> Text {
        return self.font(.custom(FontFamily.Lato.light, size: size))
    }
    
    func fontLatoLightItalic(size: CGFloat) -> Text {
        return self.font(.custom(FontFamily.Lato.lightItalic, size: size))
    }
    
    func fontLatoRegular(size: CGFloat) -> Text {
        return self.font(.custom(FontFamily.Lato.regular, size: size))
    }
    
    func fontLatoThin(size: CGFloat) -> Text {
        return self.font(.custom(FontFamily.Lato.hairline, size: size))
    }
    
    func fontLatoThinItalic(size: CGFloat) -> Text {
        return self.font(.custom(FontFamily.Lato.hairlineItalic, size: size))
    }
}
