//
//  APIGeminiMock.swift
//  SwiftExplorer
//
//  Created by João Lucas on 18/09/24.
//

//import Foundation
//import Gemini
//
//public final class APIGeminiMock: APIGeminiProtocol {
//    
//    public var failure = false
//    public var mockResult: String = "Mocked successful response"
//    
//    public init() {}
//    
//    public func result(apiKey: String, code: String, llvmCode: String, assemblyCode: String) async throws -> String {
//        try await Task.sleep(nanoseconds: 100_000_000) // Simula um pequeno atraso para parecer real
//        
//        if failure {
//            throw NSError(
//                domain: "APIGeminiMock",
//                code: -1, userInfo: [NSLocalizedDescriptionKey: "Mocked failure response"]
//            )
//        }
//        
//        return mockResult
//    }
//}
