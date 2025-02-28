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

    @MainActor
    func testShouldValidateLayout() {
        let coordinator = SwiftExplorerCoordinator(coordinator: nil)
        let compareDTO = CompareDTO(swiftCode: "22", llvmCode: "22", assemblyCode: "2445")
        let viewModel = CompareViewModel(coordinator: coordinator, compareDTO: compareDTO)
        let sut = CompareView(viewModel: viewModel)
        
        assertSnapshot(of: sut.view(width: 1280, height: 800), as: .image, record: false)
    }
}
