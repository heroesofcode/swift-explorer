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

    private let analytics: AnalyticsTracking
    private let crashlytics: CrashlyticsTracking

    init(
        analytics: AnalyticsTracking = DefaultAnalyticsTracker(),
        crashlytics: CrashlyticsTracking = DefaultCrashlyticsTracker()
    ) {
        self.analytics = analytics
        self.crashlytics = crashlytics
    }

    func generate() {
        guard !swiftCode.isEmpty else {
            showAlert = true
            analytics.event(AnalyticsEvents.Home.emptyField.rawValue)
            return
        }

        llvm = Llvm().generateLlvm(
            swiftCode: swiftCode,
            optimizationLevel: optimizationLevel
        )
        
        assemblyCode = Assembly().generateAssembly(
            fromSwiftCode: swiftCode,
            optimizationLevel: optimizationLevel
        )

        analytics.event(AnalyticsEvents.Home.button.rawValue)
        crashlytics.event(CrashlyticsEvents.Home.button.rawValue)
    }

    func onAppear() {
        analytics.event(AnalyticsEvents.Home.view.rawValue)
    }
}
