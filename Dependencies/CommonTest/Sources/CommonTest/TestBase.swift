//
//  TestBase.swift
//  CommonTest
//
//  Created by João Lucas on 09/07/25.
//

import XCTest
import SnapshotTesting
import SwiftUI

/// A base test class that provides snapshot testing utilities for SwiftUI views on macOS.
///
/// This class includes a custom `assertSnapshot` method to easily capture and validate
/// the rendered appearance of SwiftUI views, using configurable parameters such as size and color scheme.
open class TestBase: XCTestCase {

    /// Asserts a snapshot of the given SwiftUI view using `SnapshotTesting`.
    ///
    /// - Parameters:
    ///   - view: The SwiftUI view to be snapshot tested.
    ///   - width: The width of the view to render. Defaults to `1280`.
    ///   - height: The height of the view to render. Defaults to `800`.
    ///   - colorScheme: The color scheme (light or dark) to apply to the view environment. Defaults to `.light`.
    ///   - isSnapshot: A flag that allows skipping the snapshot assertion when set to `false`. Defaults to `true`.
    ///   - file: The file name where the failure occurs. Defaults to the calling file.
    ///   - testName: The name of the test function. Defaults to the calling function.
    ///   - line: The line number where the failure occurs. Defaults to the current line.
    public func assertSnapshot<V: View>(
        of view: V,
        width: CGFloat = 1280,
        height: CGFloat = 800,
        colorScheme: ColorScheme = .light,
        isSnapshot: Bool = true,
        file: StaticString = #file,
        testName: String = #function,
        line: UInt = #line
    ) {
        guard isSnapshot else { return }

        let nsView = view.view(
            width: width,
            height: height,
            colorScheme: colorScheme
        )

        SnapshotTesting.assertSnapshot(
            of: nsView,
            as: .image,
            file: file,
            testName: testName,
            line: line
        )
    }
}
