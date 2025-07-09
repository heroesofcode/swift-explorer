//
//  HomeViewTests.swift
//  SwiftExplorer
//
//  Created by João Lucas on 22/06/24.
//

import CommonTest
import XCTest
@testable import SwiftExplorer

final class HomeViewTests: TestBase {

    func testShouldValidateLayout() {
        let sut = HomeView()
        self.assertSnapshot(of: sut)
    }
}
