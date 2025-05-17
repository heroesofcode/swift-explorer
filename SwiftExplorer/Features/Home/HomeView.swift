//
//  HomeView.swift
//  SwiftExplorer
//
//  Created by João Lucas on 22/06/24.
//

import CodeEditor
import Lowlevel
import SwiftUI
import Theme
import Analytics

struct HomeView: View {
    @State private var swiftCode: String = ""
    @State private var llvm: String = ""
    @State private var assemblyCode: String = ""
    @State private var optimizationLevel: OptimizationLevel = .balanced

    @State private var fontSize: Int = 14
    @State private var showAlert = false

    @State private var navigation = NavigationPath()

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
            SetAnalyticsEvents.event(AnalyticsEvents.Home.view.rawValue)
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

            CodeEditor(
                source: $swiftCode,
                language: .swift,
                theme: .atelierSavannaLight,
                fontSize: .init(get: { CGFloat(16) },
                                set: { fontSize = Int($0) })
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

            CodeEditor(
                source: $llvm,
                language: .bash,
                theme: .atelierSavannaLight,
                fontSize: .init(get: { CGFloat(16) },
                                set: { fontSize = Int($0) })
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

            CodeEditor(
                source: $assemblyCode,
                language: .bash,
                theme: .atelierSavannaLight,
                fontSize: .init(get: { CGFloat(16) },
                                set: { fontSize = Int($0) })
            )
            .border(Color.blackColor, width: 2)
            .frame(maxWidth: .infinity)
        }
        .padding([.leading, .trailing], 4)
    }
    
    private func exploreButtonView() -> some View {
        Button {
            if !swiftCode.isEmpty {
                let llvm = Llvm(
                    swiftCode: $swiftCode,
                    llvm: $llvm,
                    optimizationLevel: $optimizationLevel
                )

                llvm.generateLlvm()

                assemblyCode = Assembly().generateAssembly(
                    fromSwiftCode: swiftCode,
                    optimizationLevel: optimizationLevel
                )

                SetAnalyticsEvents.event(AnalyticsEvents.Home.button.rawValue)
            } else {
                showAlert = true
                SetAnalyticsEvents.event(AnalyticsEvents.Home.empty_field.rawValue)
            }
        } label: {
            Text("Click to explore")
                .fontLatoBlack(size: 16)
                .foregroundColor(.swiftColor)
                .padding()
                .cornerRadius(8)
        }
        .buttonStyle(.link)
        .alert(isPresented: $showAlert) {
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
                    optimizationLevel = level
                } label: {
                    Text(level.rawValue)
                        .fontLatoRegular(size: 14)
                }
            }
        } label: {
            HStack {
                Text("Optmization Level: \(optimizationLevel.rawValue)")
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
