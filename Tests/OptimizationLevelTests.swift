//
//  OptimizationLevelTests.swift
//  SwiftExplorer
//
//  Created by João Lucas on 22/02/26.
//

import XCTest
import Lowlevel
@testable import SwiftExplorer

final class OptimizationLevelTests: XCTestCase {
    
    func testAllOptimizationLevelsAreValid() {
        for level in OptimizationLevel.allCases {
            XCTAssertFalse(level.rawValue.isEmpty)
            XCTAssertTrue(level.rawValue.hasPrefix("-O"))
        }
    }
    
    func testOptimizationLevelEquality() {
        XCTAssertEqual(OptimizationLevel.balanced, .balanced)
        XCTAssertNotEqual(OptimizationLevel.balanced, .none)
    }
}
