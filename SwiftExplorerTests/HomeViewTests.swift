//
//  HomeViewTests.swift
//  SwiftExplorer
//
//  Created by João Lucas on 22/06/24.
//

import CommonTest
import XCTest
import Common
@testable import SwiftExplorer

final class HomeViewTests: TestBase {

    override func setUp() {
        super.setUp()

        startDI(modules: [
            { $0.factory { HomeViewModel() } }
        ])
    }

    func testShouldValidateLayout() {
        let sut = HomeView()
            .frame(width: 1280, height: 800)

        self.compareSnapshot(of: sut)
    }
}
