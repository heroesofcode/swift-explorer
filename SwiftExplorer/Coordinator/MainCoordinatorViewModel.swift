//
//  MainCoordinatorViewModel.swift
//  SwiftExplorer
//
//  Created by João Lucas on 28/02/25.
//

import SwiftUI
import Coordinator

@MainActor
final class MainCoordinatorViewModel: Coordinator {
    
    var coordinator: (any Coordinator)?
    
    @Published var path: [PresentationModel] = []
    
    lazy var swiftExplorerCoordinator = SwiftExplorerCoordinator(coordinator: self)
    
    func start() -> PresentationModel {
        return PresentationModel()
    }

    @ViewBuilder
    func createView(presentationModel: PresentationModel) -> some View {
        swiftExplorerCoordinator.createView(presentationModel: presentationModel)
    }
}

extension MainCoordinatorViewModel {
    
    func navigateTo(_ page: PresentationModel) {
        path.append(page)
    }
    
    func back() {
        path.removeLast()
    }
}
