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

    @MainActor
    func testShouldValidateLayout() {
        let coordinator = SwiftExplorerCoordinator(coordinator: nil)
        let viewModel = HomeViewModel(coordinator: coordinator)
        let sut = HomeView(viewModel: viewModel)
        
        assertSnapshot(of: sut.view(width: 1280, height: 800), as: .image, record: false)
    }
}
