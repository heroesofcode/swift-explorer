//
//  CustomCodeEditorViewTests.swift
//  Theme
//
//  Created by João Lucas on 09/07/25.
//

import XCTest
import SwiftUI
import CommonTest
@testable import Theme

final class CustomCodeEditorViewTests: TestBase {
    
    func testCustomCodeEditorView() {
        let code = """
        import Foundation

        print("Hello, world!")
        """

        let view = CustomCodeEditorView(
            source: .constant(code),
            language: .swift,
            theme: .atelierSavannaLight,
            fontSize: 16
        )
        .frame(width: 300, height: 200)

        self.assertSnapshot(of: view)
    }
}
