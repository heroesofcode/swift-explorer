//
//  AboutViewTests.swift
//  SwiftExplorer
//
//  Created by João Lucas on 09/07/25.
//

import CommonTest
import XCTest
@testable import SwiftExplorer

final class AboutViewTests: TestBase {

    func testShouldValidateAboutViewLayout() {
        let sut = AboutView()
            .frame(width: 500, height: 500)
        
        self.compareSnapshot(of: sut)
    }
}
