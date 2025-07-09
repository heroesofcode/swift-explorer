//
//  HomeView.swift
//  SwiftExplorer
//
//  Created by João Lucas on 22/06/24.
//

import Lowlevel
import SwiftUI
import Theme

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()

    @State private var fontSize: Int = 14

    var body: some View {
        VStack {
            HStack {
                swiftView()
                llvmView()
                assemblyView()
            }

            HStack {
                exploreButtonView()
                optmizationLevelMenuView()
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
        .background(.white)
    }
    
    private func swiftView() -> some View {
        VStack {
            HStack {
                Text(L10n.swift)
                    .bold()
                    .fontLatoBold(size: 20)
                    .foregroundColor(.swiftColor)
                Spacer()
            }

            CustomCodeEditorView(
                source: $viewModel.swiftCode,
                language: .swift,
                theme: .atelierSavannaLight
            )
            .border(Color.blackColor, width: 2)
            .font(.system(size: 100))
            .frame(maxWidth: .infinity)
        }
        .padding(.leading, 4)
    }
    
    private func llvmView() -> some View {
        VStack {
            HStack {
                Text(L10n.llvm)
                    .bold()
                    .fontLatoBold(size: 20)
                    .foregroundColor(.swiftColor)
                Spacer()
            }

            CustomCodeEditorView(
                source: $viewModel.llvm,
                language: .bash,
                theme: .atelierSavannaLight
            )
            .border(Color.blackColor, width: 2)
            .frame(maxWidth: .infinity)
        }
        .padding(.leading, 4)
    }
    
    private func assemblyView() -> some View {
        VStack {
            HStack {
                Text(L10n.assembly)
                    .bold()
                    .fontLatoBold(size: 20)
                    .foregroundColor(.swiftColor)
                Spacer()
            }

            CustomCodeEditorView(
                source: $viewModel.assemblyCode,
                language: .bash,
                theme: .atelierSavannaLight
            )
            .border(Color.blackColor, width: 2)
            .frame(maxWidth: .infinity)
        }
        .padding([.leading, .trailing], 4)
    }
    
    private func exploreButtonView() -> some View {
        Button {
            let llvm = Llvm(
                swiftCode: $viewModel.swiftCode,
                llvm: $viewModel.llvm,
                optimizationLevel: $viewModel.optimizationLevel
            )
            
            viewModel.tapGenerate(llvm: llvm)
        } label: {
            Text(L10n.exploreButton)
                .fontLatoBlack(size: 16)
                .foregroundColor(.swiftColor)
                .padding()
                .cornerRadius(8)
        }
        .buttonStyle(.link)
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text(L10n.warning),
                message: Text(L10n.messageEmptyField),
                dismissButton: .default(Text(L10n.ok))
            )
        }
    }
    
    private func optmizationLevelMenuView() -> some View {
        Menu {
            ForEach(OptimizationLevel.allCases, id: \.self) { level in
                Button {
                    viewModel.optimizationLevel = level
                } label: {
                    Text(level.rawValue)
                        .fontLatoRegular(size: 14)
                }
            }
        } label: {
            HStack {
                Text(L10n.optmizationLevelTitle(viewModel.optimizationLevel.rawValue))
                    .foregroundColor(Color.blackColor)
                Image(systemName: "chevron.down")
                    .foregroundColor(.swiftColor)
            }
            .padding()
            .background(Color.swiftColor)
            .cornerRadius(8)
        }
        .frame(width: 300)
    }
}
