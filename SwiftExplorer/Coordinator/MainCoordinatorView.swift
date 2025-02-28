//
//  MainCoordinatorView.swift
//  SwiftExplorer
//
//  Created by João Lucas on 28/02/25.
//

import SwiftUI
import Coordinator

struct MainCoordinatorView: View {

    @ObservedObject var viewModel: MainCoordinatorViewModel

    var body: some View {
        ZStack {
            NavigationStack(path: $viewModel.path) {
                viewModel.createView(presentationModel: viewModel.swiftExplorerCoordinator.start())
                    .navigationDestination(for: PresentationModel.self) { page in
                        viewModel.createView(presentationModel: page)
                    }
            }
            .accentColor(.white)
        }
    }
}
