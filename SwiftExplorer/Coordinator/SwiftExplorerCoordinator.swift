//
//  SwiftExplorerCoordinator.swift
//  SwiftExplorer
//
//  Created by João Lucas on 28/02/25.
//

import SwiftUI
import Coordinator

final class SwiftExplorerCoordinator: Coordinator {    
    
    public weak var coordinator: (any Coordinator)?
    
    public init(coordinator: (any Coordinator)?) {
        self.coordinator = coordinator
    }
    
    @MainActor
    public func start() -> PresentationModel {
        return HomeViewModel(coordinator: self)
    }
    
    @ViewBuilder @MainActor
    public func createView(presentationModel: PresentationModel) -> some View {
        switch presentationModel {
        case let viewModel as HomeViewModel: HomeView(viewModel: viewModel)
        case let viewModel as CompareViewModel: CompareView(viewModel: viewModel)
        default: EmptyView()
        }
    }
}

extension SwiftExplorerCoordinator {
    
    func goToCompareView(compareDTO: CompareDTO) {
        let viewModel = CompareViewModel(coordinator: self, compareDTO: compareDTO)
        coordinator?.navigateTo(viewModel)
    }
}
