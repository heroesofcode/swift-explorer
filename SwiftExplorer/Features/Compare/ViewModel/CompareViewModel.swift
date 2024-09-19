//
//  CompareViewModel.swift
//  SwiftExplorer
//
//  Created by João Lucas on 16/09/24.
//

import Foundation
import Gemini

protocol CompareViewModelProtocol: ObservableObject {
    var resultText: String { get set }
    func resultGemini(apiKey: String,
                      swiftCode: String,
                      llvmCode: String,
                      assemblyCode: String)
}

final class CompareViewModel: CompareViewModelProtocol {
    
    @Published var resultText: String = ""
    
    private let apiGemini: APIGeminiProtocol
    
    init(apiGemini: APIGeminiProtocol = APIGemini()) {
        self.apiGemini = apiGemini
    }
    
    func resultGemini(apiKey: String,
                      swiftCode: String,
                      llvmCode: String,
                      assemblyCode: String) {
        Task {
            await validationResult(
                apiKey: apiKey,
                swiftCode: swiftCode,
                llvmCode: llvmCode,
                assemblyCode: assemblyCode)
        }
    }
    
    private func validationResult(
        apiKey: String,
        swiftCode: String,
        llvmCode: String,
        assemblyCode: String) async {
            
        await APIGemini().result(
            apiKey: apiKey,
            code: swiftCode,
            llvmCode: llvmCode,
            assemblyCode: assemblyCode) { result in
                switch result {
                case .success(let text):
                    DispatchQueue.main.async {
                        self.resultText = text
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.resultText = error.localizedDescription
                    }
                }
            }
    }
}
