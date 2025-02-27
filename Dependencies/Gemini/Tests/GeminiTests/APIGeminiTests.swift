import XCTest
@testable import Gemini

final class APIGeminiTests: XCTestCase {

    var apiGemini: APIGemini!

    override func setUp() {
        super.setUp()
        apiGemini = APIGemini()
    }

    override func tearDown() {
        apiGemini = nil
        super.tearDown()
    }
    
    func testResultFailure() async throws {
        let expectation = XCTestExpectation(description: "Completion handler invoked")

        let mockInvalidApiKey = "invalidApiKey"
        let mockSwiftCode = "print('Hello World')"
        let mockLLVMCode = "llvm code"
        let mockAssemblyCode = "assembly code"

        await apiGemini.result(
            apiKey: mockInvalidApiKey,
            code: mockSwiftCode,
            llvmCode: mockLLVMCode,
            assemblyCode: mockAssemblyCode
        ) { result in
            switch result {
            case .success:
                XCTFail("Success")
            case .failure(let error):
                XCTAssertNotNil(error, "Error")
                expectation.fulfill()
            }
        }

        await fulfillment(of: [expectation], timeout: 1.0)
    }
}
