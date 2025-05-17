//
//  HomeViewTests.swift
//  SwiftExplorer
//
//  Created by João Lucas on 22/06/24.
//

import CommonTest
import SnapshotTesting
import XCTest
@testable import SwiftExplorer

final class HomeViewTests: XCTestCase {

    func testShouldValidateLayout() {
        let sut = HomeView()
        let view = sut.view(width: 1280, height: 800)
        assertSnapshot(of: view, as: .image)
    }
}
