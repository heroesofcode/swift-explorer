//
//  HomeView.swift
//  SwiftExplorer
//
//  Created by João Lucas on 22/06/24.
//

import Lowlevel
import SwiftUI
import DesignSystem
import Common

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()

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
                    .font(.latoBold(size: 20))
                    .foregroundColor(.themeSwift)
                Spacer()
            }

            CustomCodeEditorView(
                source: $viewModel.swiftCode,
                language: .swift,
                theme: .atelierSavannaLight
            )
            .border(Color.themeBlack, width: 2)
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
                    .font(.latoBold(size: 20))
                    .foregroundColor(.themeSwift)
                Spacer()
            }

            CustomCodeEditorView(
                source: $viewModel.llvm,
                language: .bash,
                theme: .atelierSavannaLight
            )
            .border(Color.themeBlack, width: 2)
            .frame(maxWidth: .infinity)
        }
        .padding(.leading, 4)
    }
    
    private func assemblyView() -> some View {
        VStack {
            HStack {
                Text(L10n.assembly)
                    .bold()
                    .font(.latoBold(size: 20))
                    .foregroundColor(.themeSwift)
                Spacer()
            }

            CustomCodeEditorView(
                source: $viewModel.assemblyCode,
                language: .bash,
                theme: .atelierSavannaLight
            )
            .border(Color.themeBlack, width: 2)
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
                .font(.latoBlack(size: 16))
                .foregroundColor(.themeSwift)
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
        ButtonSelect(backgroundColor: Color.themeSwift) {
            Text(L10n.optmizationLevelTitle(viewModel.optimizationLevel.rawValue))
                .foregroundColor(.white)
                .font(.latoBlack(size: 13))
        } content: { dismiss in
            VStack(spacing: 4) {
                ForEach(OptimizationLevel.allCases, id: \.self) { level in
                    Button {
                        viewModel.optimizationLevel = level
                        dismiss()
                    } label: {
                        Text(level.rawValue)
                            .font(.latoRegular(size: 14))
                            .foregroundColor(.themeBlack)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(Color.themeGrayClear)
                            .cornerRadius(4)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .frame(width: 240)
    }
}
