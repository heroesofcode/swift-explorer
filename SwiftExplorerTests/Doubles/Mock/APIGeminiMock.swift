//
//  APIGeminiMock.swift
//  SwiftExplorer
//
//  Created by João Lucas on 18/09/24.
//

import Foundation
import Gemini

final class APIGeminiMock: APIGeminiProtocol {
    
    var failure = false
    var mockResult: String = "Mocked successful response"
    
    func result(
        apiKey: String,
        code: String,
        llvmCode: String,
        assemblyCode: String,
        completion: @escaping (Result<String, Error>) -> Void
    ) async {
        try? await Task.sleep(nanoseconds: 100_000_000)
        
        if failure {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Mocked error"])))
        } else {
            completion(.success(mockResult))
        }
    }
}
