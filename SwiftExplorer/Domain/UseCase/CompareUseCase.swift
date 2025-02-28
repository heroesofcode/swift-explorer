//
//  CompareUseCase.swift
//  SwiftExplorer
//
//  Created by João Lucas on 28/02/25.
//

import Foundation
import Gemini

protocol CompareUseCaseProtocol {
    func execute(apiKey: String,
                 swiftCode: String,
                 llvmCode: String,
                 assemblyCode: String) async -> Result<String, Error>
}

final class CompareUseCase: CompareUseCaseProtocol {
    private let apiGemini: APIGeminiProtocol

    init(apiGemini: APIGeminiProtocol = APIGemini()) {
        self.apiGemini = apiGemini
    }

    func execute(
        apiKey: String,
        swiftCode: String,
        llvmCode: String,
        assemblyCode: String
    ) async -> Result<String, Error> {
        
        do {
            let result = try await apiGemini.result(
                apiKey: apiKey,
                code: swiftCode,
                llvmCode: llvmCode,
                assemblyCode: assemblyCode
            )
            
            return .success(result)
        } catch {
            return .failure(error)
        }
    }
}
