//
//  HomeViewModelTests.swift
//  SwiftExplorer
//
//  Created by João Lucas on 22/02/26.
//

import XCTest
import Analytics
@testable import SwiftExplorer

final class HomeViewModelTests: XCTestCase {

    var sut: HomeViewModel!
    var analyticsStub: AnalyticsTrackingStub!
    var crashlyticsStub: CrashlyticsTrackingStub!

    override func setUp() {
        super.setUp()
        analyticsStub = AnalyticsTrackingStub()
        crashlyticsStub = CrashlyticsTrackingStub()
        sut = HomeViewModel(analytics: analyticsStub, crashlytics: crashlyticsStub)
    }

    override func tearDown() {
        sut = nil
        analyticsStub = nil
        crashlyticsStub = nil
        super.tearDown()
    }

    func testInitialState() {
        XCTAssertEqual(sut.swiftCode, "")
        XCTAssertEqual(sut.llvm, "")
        XCTAssertEqual(sut.assemblyCode, "")
        XCTAssertEqual(sut.optimizationLevel, .balanced)
        XCTAssertFalse(sut.showAlert)
    }

    func testGenerateWithEmptyCodeShowsAlert() {
        sut.generate()

        XCTAssertTrue(sut.showAlert)
        XCTAssertEqual(sut.assemblyCode, "")
    }

    func testGenerateWithEmptyCodeFiresEmptyFieldEvent() {
        sut.generate()

        XCTAssertEqual(analyticsStub.loggedEvents, [AnalyticsEvents.Home.emptyField.rawValue])
    }

    func testGenerateWithValidCodeUpdatesAssembly() {
        sut.swiftCode = "let x = 5"
        sut.generate()

        XCTAssertFalse(sut.assemblyCode.isEmpty)
        XCTAssertFalse(sut.showAlert)
    }

    func testGenerateWithValidCodeFiresButtonEvent() {
        sut.swiftCode = "let x = 5"
        sut.generate()

        XCTAssertEqual(analyticsStub.loggedEvents, [AnalyticsEvents.Home.button.rawValue])
        XCTAssertEqual(crashlyticsStub.loggedEvents, [CrashlyticsEvents.Home.button.rawValue])
    }

    func testOnAppearFiresViewEvent() {
        sut.onAppear()

        XCTAssertEqual(analyticsStub.loggedEvents, [AnalyticsEvents.Home.view.rawValue])
    }

    func testOptimizationLevelChange() {
        sut.optimizationLevel = .none
        XCTAssertEqual(sut.optimizationLevel, .none)

        sut.optimizationLevel = .size
        XCTAssertEqual(sut.optimizationLevel, .size)

        sut.optimizationLevel = .unchecked
        XCTAssertEqual(sut.optimizationLevel, .unchecked)

        sut.optimizationLevel = .balanced
        XCTAssertEqual(sut.optimizationLevel, .balanced)
    }
}

// MARK: - Stubs

final class AnalyticsTrackingStub: AnalyticsTracking {
    private(set) var loggedEvents: [String] = []
    func event(_ name: String) { loggedEvents.append(name) }
}

final class CrashlyticsTrackingStub: CrashlyticsTracking {
    private(set) var loggedEvents: [String] = []
    func event(_ name: String) { loggedEvents.append(name) }
}
