import XCTest
@testable import Gemini

final class APIGeminiTests: XCTestCase {

    var apiGemini: APIGeminiMock!

    override func setUp() {
        super.setUp()
        apiGemini = APIGeminiMock()
    }

    override func tearDown() {
        apiGemini = nil
        super.tearDown()
    }
    
    func testResultSuccess() async throws {

        let mockInvalidApiKey = "invalidApiKey"
        let mockSwiftCode = "print('Hello World')"
        let mockLLVMCode = "llvm code"
        let mockAssemblyCode = "assembly code"
        
        do {
            let result = try await apiGemini.result(
                apiKey: mockInvalidApiKey,
                code: mockSwiftCode,
                llvmCode: mockLLVMCode,
                assemblyCode: mockAssemblyCode
            )
            
            XCTAssertEqual(result, "Mocked successful response")
        } catch {
            fatalError()
        }
    }
}
