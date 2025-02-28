//
//  HomeViewModel.swift
//  SwiftExplorer
//
//  Created by João Lucas on 28/02/25.
//

import SwiftUI
import Coordinator
import Lowlevel

@MainActor
final class HomeViewModel: PresentationModel {
    
    weak var coordinator: SwiftExplorerCoordinator?
    
    init(coordinator: SwiftExplorerCoordinator) {
        self.coordinator = coordinator
    }
}

extension HomeViewModel {
    
    func goToCompare(dto: CompareDTO) {
        coordinator?.goToCompareView(compareDTO: dto)
    }
}
