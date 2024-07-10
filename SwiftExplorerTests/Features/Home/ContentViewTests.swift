//
//  ContentViewTests.swift
//  SwiftExplorerTests
//
//  Created by João Lucas on 22/06/24.
//

import XCTest
import SnapshotTesting
import CommonTest
@testable import SwiftExplorer

final class ContentViewTests: XCTestCase {

    func testShouldValidateLayout() {
        let view = ContentView()
        
        guard let width = NSScreen.main?.frame.width else { return }
        assertSnapshot(of: view.view(width: width, height: 800), as: .image)
    }
}
