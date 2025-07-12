//
//  TestBase.swift
//  CommonTest
//
//  Created by João Lucas on 09/07/25.
//

import SwiftUI
import SnapshotTesting
import Testing
import XCTest

/// Inherit from this class to create your tests and override the isRecording property
@MainActor
open class TestBase: XCTestCase {
    
    /// Override this value to record all snapshots again
    open var isRecording: Bool { false }
    
    /// Compares or record a snapshot
    /// - Parameters:
    ///   - view: the view to snapshot
    ///   - isRecording: True if you want to record the snapshot. False otherwise. Leave it nil to default to false.
    ///   - file: file reference for test
    ///   - testName: file name reference for test
    ///   - line: line reference for test
    public func compareSnapshot<V: View>(
        of view: V,
        isRecording: Bool? = nil,
        file: StaticString = #file,
        testName: String = #function,
        line: UInt = #line
    ) {
        assertSnapshot(
            of: view.view(),
            as: .image,
            record: isRecording ?? self.isRecording,
            file: file,
            testName: testName,
            line: line
        )
    }
}
