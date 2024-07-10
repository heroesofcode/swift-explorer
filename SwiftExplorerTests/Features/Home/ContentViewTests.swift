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
        assertSnapshot(of: view.view(width: 1280, height: 800), as: .image)
    }
}
