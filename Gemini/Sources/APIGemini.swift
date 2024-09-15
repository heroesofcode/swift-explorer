import GoogleGenerativeAI

public final class APIGemini {
    
    public init() {}
    
    public func result(apiKey: String, llvmCode: String, assemblyCode: String) async {
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
                print("Response the gemini: \(text)")
            }
        } catch {
            print("Error gemini: \(error)")
        }
    }
}
