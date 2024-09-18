//
//  APIGeminiMock.swift
//  SwiftExplorerTests
//
//  Created by João Lucas on 17/09/24.
//

import XCTest
@testable import Gemini

final class APIGeminiMock: APIGeminiProtocol {
    var shouldReturnError = false
    var mockResponseText: String = "Mocked successful response"
    
    func result(
        apiKey: String,
        code: String,
        llvmCode: String,
        assemblyCode: String,
        completion: @escaping (Result<String, any Error>) -> Void
    ) async {
        try? await Task.sleep(nanoseconds: 100_000_000)
        
        if shouldReturnError {
            completion(.failure(NSError(domain: "MockError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Mocked error"])))
        } else {
            completion(.success(mockResponseText))
        }
    }
}
