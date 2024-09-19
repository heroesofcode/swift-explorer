//
//  CompareViewModelTests.swift
//  SwiftExplorer
//
//  Created by João Lucas on 18/09/24.
//

import XCTest
@testable import SwiftExplorer

final class CompareViewModelTests: XCTestCase {
    
    var viewModel: CompareViewModel!
    var mockAPIGemini: APIGeminiMock!
    
    override func setUp() {
        super.setUp()
        mockAPIGemini = APIGeminiMock()
        viewModel = CompareViewModel(apiGemini: mockAPIGemini)
    }
    
    override func tearDown() {
        viewModel = nil
        mockAPIGemini = nil
        super.tearDown()
    }
    
    func testResultGeminiSuccess() {
        let expectedText = "Mocked successful response"
        mockAPIGemini.mockResult = expectedText
        
        viewModel.resultGemini(
            apiKey: "dummyApiKey",
            swiftCode: "print('Hello, World!')",
            llvmCode: "llvmCode",
            assemblyCode: "assemblyCode"
        )
        
        // TODO: - Review this test
        XCTAssertEqual(viewModel.resultText, "")
    }
    
    func testResultGeminiFailure() {
        mockAPIGemini.failure = true
        
        viewModel.resultGemini(
            apiKey: "dummyApiKey",
            swiftCode: "print('Hello, World!')",
            llvmCode: "llvmCode",
            assemblyCode: "assemblyCode"
        )
        
        XCTAssertEqual(viewModel.resultText, "")
    }
}

