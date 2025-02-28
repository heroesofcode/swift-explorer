//
//  CompareViewModel.swift
//  SwiftExplorer
//
//  Created by João Lucas on 16/09/24.
//

import Foundation
import Gemini
import Analytics
import Coordinator

final class CompareViewModel: PresentationModel {
    
    @Published var resultText: String = ""
    @Published var apiKey: String = ""
    @Published var compareDTO: CompareDTO
    
    weak var coordinator: SwiftExplorerCoordinator?
    private let useCase: CompareUseCaseProtocol
    
    init(
        coordinator: SwiftExplorerCoordinator,
        useCase: CompareUseCaseProtocol = CompareUseCase(),
        compareDTO: CompareDTO
    ) {
        self.coordinator = coordinator
        self.useCase = useCase
        self.compareDTO = compareDTO
    }
}

extension CompareViewModel {
    func didTapCompare(apiKey: String) {
        SetAnalyticsEvents.event(AnalyticsEvents.Compare.button.rawValue)
        resultGemini(
            apiKey: apiKey,
            swiftCode: compareDTO.swiftCode,
            llvmCode: compareDTO.llvmCode,
            assemblyCode: compareDTO.assemblyCode
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
