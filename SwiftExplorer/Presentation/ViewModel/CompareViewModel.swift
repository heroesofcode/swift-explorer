//
//  CompareViewModel.swift
//  SwiftExplorer
//
//  Created by João Lucas on 16/09/24.
//

import Foundation
import Gemini
import Analytics

protocol CompareViewModelProtocol: ObservableObject {
    var resultText: String { get set }
    var apiKey: String { get set }
    
    func didTapCompare(
        apiKey: String,
        swiftCode: String,
        llvmCode: String,
        assemblyCode: String
    )
    func didAppear()
}

final class CompareViewModel: CompareViewModelProtocol, @unchecked Sendable {
    
    @Published var resultText: String = ""
    @Published var apiKey: String = ""
    
    private let useCase: CompareUseCaseProtocol
    
    init(useCase: CompareUseCaseProtocol = CompareUseCase()) {
        self.useCase = useCase
    }
    
    func didTapCompare(
        apiKey: String,
        swiftCode: String,
        llvmCode: String,
        assemblyCode: String
    ) {
        SetAnalyticsEvents.event(AnalyticsEvents.Compare.button.rawValue)
        resultGemini(
            apiKey: apiKey,
            swiftCode: swiftCode,
            llvmCode: llvmCode,
            assemblyCode: assemblyCode
        )
    }
    
    func didAppear() {
        SetAnalyticsEvents.event(AnalyticsEvents.Compare.view.rawValue)
    }
}

extension CompareViewModel {
    
    private func resultGemini(
        apiKey: String,
        swiftCode: String,
        llvmCode: String,
        assemblyCode: String
    ) {
        
        Task { @MainActor in
            let result = await useCase.execute(
                apiKey: apiKey,
                swiftCode: swiftCode,
                llvmCode: llvmCode,
                assemblyCode: assemblyCode
            )
            
            switch result {
            case .success(let text):
                self.resultText = text
                SetAnalyticsEvents.event(AnalyticsEvents.Compare.success.rawValue)
            case .failure(let error):
                self.resultText = error.localizedDescription
                SetAnalyticsEvents.event(AnalyticsEvents.Compare.error.rawValue)
            }
        }
    }
}
