//
//  CompareViewTests.swift
//  SwiftExplorer
//
//  Created by João Lucas on 17/09/24.
//

import CommonTest
import SnapshotTesting
import XCTest
@testable import SwiftExplorer

final class CompareViewTests: XCTestCase {

    func testShouldValidateLayout() {
        let sut = CompareView(swiftCode: "code", llvmCode: "lvvm", assemblyCode: "assembly")
        assertSnapshot(of: sut.view(width: 1280, height: 800), as: .image)
    }
}
