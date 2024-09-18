//
//  ContentViewTests.swift
//  SwiftExplorer
//
//  Created by João Lucas on 22/06/24.
//

import CommonTest
import SnapshotTesting
import XCTest
@testable import SwiftExplorer

final class ContentViewTests: XCTestCase {

    func testShouldValidateLayout() {
        let sut = ContentView()
        assertSnapshot(of: sut.view(width: 1280, height: 800), as: .image)
    }
}
