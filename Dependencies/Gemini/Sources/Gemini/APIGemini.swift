import Foundation
import GoogleGenerativeAI

public protocol APIGeminiProtocol {
    func result(
        apiKey: String,
        code: String,
        llvmCode: String,
        assemblyCode: String
    ) async throws -> String
}

public final class APIGemini: APIGeminiProtocol {
    
    public init() {}

    public func result(
        apiKey: String,
        code: String,
        llvmCode: String,
        assemblyCode: String
    ) async throws -> String {
            
        let generativeModel = GenerativeModel(
            name: "gemini-1.5-flash",
            apiKey: apiKey
        )

        let prompt = """
        What can improve the performance of the code, do an analysis of the LLVM and the Assembly generated from the code, what would the code be like to improve the performance of the code I wrote? Give me examples

        Code:
        \(code)

        LLVM IR:
        \(llvmCode)

        Assembly:
        \(assemblyCode)
        """

        let response = try await generativeModel.generateContent(prompt)

        guard let text = response.text else {
            throw NSError(
                domain: "APIGemini",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "No response text"]
            )
        }

        return text
    }
}
