import XCTest
@testable import Gemini

final class APIGeminiTests: XCTestCase {
    
    var mockAPIGemini: APIGeminiMock!
    
    override func setUp() {
        super.setUp()
        mockAPIGemini = APIGeminiMock()
    }
    
    override func tearDown() {
        mockAPIGemini = nil
        super.tearDown()
    }
    
    func testResultSuccess() async {
        let expectation = XCTestExpectation(description: "Completion handler invoked")
        mockAPIGemini.mockResponseText = "Mocked successful response"
        

        await mockAPIGemini.result(
            apiKey: "dummyApiKey",
            code: "swift code",
            llvmCode: "llvm code",
            assemblyCode: "assembly code"
        ) { result in
            switch result {
            case .success(let text):
                // Assert
                XCTAssertEqual(text, "Mocked successful response")
                expectation.fulfill()
            case .failure:
                XCTFail("Expected success but got failure")
            }
        }
        
        await fulfillment(of: [expectation], timeout: 1.0)
    }
    
    func testResultFailure() async {
        let expectation = XCTestExpectation(description: "Completion handler invoked")
        mockAPIGemini.shouldReturnError = true
        
        await mockAPIGemini.result(
            apiKey: "dummyApiKey",
            code: "swift code",
            llvmCode: "llvm code",
            assemblyCode: "assembly code"
        ) { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                // Assert
                XCTAssertEqual(error.localizedDescription, "Mocked error")
                expectation.fulfill()
            }
        }
        
        await fulfillment(of: [expectation], timeout: 1.0)
    }
}
