import GoogleGenerativeAI

public protocol APIGeminiProtocol {
    func result(
        apiKey: String,
        llvmCode: String,
        assemblyCode: String,
        completion: @escaping (Result<String, Error>) -> Void) async
}

public final class APIGemini: APIGeminiProtocol {
    
    public init() {}
    
    public func result(
        apiKey: String,
        llvmCode: String,
        assemblyCode: String,
        completion: @escaping (Result<String, Error>) -> Void) async {
            
        let generativeModel = GenerativeModel(
            name: "gemini-1.5-flash",
            apiKey: apiKey
        )

        let prompt = """
        Compare the following LLVM IR and Assembly code. Explain which is more efficient and how the instructions are optimized.

        LLVM IR:
        \(llvmCode)

        Assembly:
        \(assemblyCode)
        """

        do {
            let response = try await generativeModel.generateContent(prompt)
            
            if let text = response.text {
                completion(.success(text))
            }
        } catch {
            completion(.failure(error))
        }
    }
}
