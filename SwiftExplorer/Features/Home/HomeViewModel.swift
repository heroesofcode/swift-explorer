//
//  HomeViewModel.swift
//  SwiftExplorer
//
//  Created by João Lucas on 05/07/25.
//

import Foundation
import Lowlevel
import Analytics

final class HomeViewModel: ObservableObject {
    
    @Published var swiftCode: String = ""
    @Published var llvm: String = ""
    @Published var assemblyCode: String = ""
    @Published var optimizationLevel: OptimizationLevel = .balanced
    @Published var showAlert = false
    
    func tapGenerate(llvm: Llvm) {
        if !swiftCode.isEmpty {
            llvm.generateLlvm()

            assemblyCode = Assembly().generateAssembly(
                fromSwiftCode: swiftCode,
                optimizationLevel: optimizationLevel
            )

            SetAnalyticsEvents.event(AnalyticsEvents.Home.button.rawValue)
            SetCrashlyticsEvents.event(CrashlyticsEvents.Home.button.rawValue)
        } else {
            showAlert = true
            SetAnalyticsEvents.event(AnalyticsEvents.Home.emptyField.rawValue)
        }
    }
    
    func onAppear() {
        SetAnalyticsEvents.event(AnalyticsEvents.Home.view.rawValue)
    }
}
