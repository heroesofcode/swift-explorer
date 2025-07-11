//
//  SwiftUI+Tests.swift
//
//
//  Created by João Lucas on 22/06/24.
//

import SwiftUI

/// Extension to convert any SwiftUI `View` into an `NSView` for testing purposes on macOS.
///
/// This is useful when writing snapshot tests or manually inspecting SwiftUI views in a macOS test environment.
public extension View {

    func view(
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        colorScheme: ColorScheme? = nil) -> NSView {
            
        let hostingController = NSHostingController(
            rootView: environment(\.colorScheme, colorScheme ?? .light)
        )

        var frameWidth: CGFloat = width ?? hostingController.view.fittingSize.width
        var frameHeight: CGFloat = height ?? hostingController.view.fittingSize.height

        frameWidth = max(frameWidth, 100)
        frameHeight = max(frameHeight, 100)

        let frame = NSRect(x: 0, y: 0, width: frameWidth, height: frameHeight)

        let window = NSWindow(
            contentRect: frame,
            styleMask: [.titled, .closable, .resizable],
            backing: .buffered, 
            defer: false)
            
        window.contentViewController = hostingController
        window.makeKeyAndOrderFront(nil)

        window.backgroundColor = colorScheme == .light ? NSColor.white : NSColor.black

        window.contentView?.frame = frame

        return hostingController.view
    }
}
