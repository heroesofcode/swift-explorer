import GoogleGenerativeAI

public protocol APIGeminiProtocol {
    func result(
        apiKey: String,
        code: String,
        llvmCode: String,
        assemblyCode: String,
        completion: @escaping (Result<String, Error>) -> Void) async
}

public final class APIGemini: APIGeminiProtocol {
    
    public init() {}
    
    public func result(
        apiKey: String,
        code: String,
        llvmCode: String,
        assemblyCode: String,
        completion: @escaping (Result<String, Error>) -> Void) async {
            
        let generativeModel = GenerativeModel(
            name: "gemini-1.5-flash",
            apiKey: apiKey
        )

        let prompt = """
        What can improve the performance of the code, do an analysis of the LVVM and the Assembly generated from the code, what would the code be like to improve the performance of the code I wrote? Give me examples
        
        Code:
        \(code)

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
