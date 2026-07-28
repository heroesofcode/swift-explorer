//
//  HomeViewInteractionTests.swift
//  SwiftExplorer
//
//  Created by João Lucas on 22/02/26.
//

import XCTest
import SwiftUI
import Lowlevel
@testable import SwiftExplorer

final class HomeViewInteractionTests: XCTestCase {
    
    func testHomeViewInitialization() {
        let view = HomeView()
        XCTAssertNotNil(view)
    }
    
    func testHomeViewWithViewModel() {
        let viewModel = HomeViewModel()
        viewModel.swiftCode = "let x = 5"
        
        XCTAssertEqual(viewModel.swiftCode, "let x = 5")
        XCTAssertEqual(viewModel.llvm, "")
        XCTAssertEqual(viewModel.assemblyCode, "")
    }
}
