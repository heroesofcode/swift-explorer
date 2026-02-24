//
//  LlvmTests.swift
//  Lowlevel
//
//  Created by João Lucas on 22/02/26.
//

import XCTest
import SwiftUI
@testable import Lowlevel

final class LlvmTests: XCTestCase {
    
    var swiftCode: String!
    var llvm: String!
    var optimizationLevel: OptimizationLevel!
    var sut: Llvm!
    
    override func setUp() {
        super.setUp()
        swiftCode = ""
        llvm = ""
        optimizationLevel = .balanced
        sut = Llvm(
            swiftCode: .constant(swiftCode),
            llvm: .constant(llvm),
            optimizationLevel: .constant(optimizationLevel)
        )
    }
    
    override func tearDown() {
        sut = nil
        swiftCode = nil
        llvm = nil
        optimizationLevel = nil
        super.tearDown()
    }
    
    func testValidationFieldSwiftCodeCreatesTemporaryFiles() {
        swiftCode = "let x = 5"
        sut = Llvm(
            swiftCode: .constant(swiftCode),
            llvm: .constant(llvm),
            optimizationLevel: .constant(optimizationLevel)
        )
        
        let (tempFile, outputFile) = sut.validationFieldSwiftCode()
        
        XCTAssertTrue(tempFile.contains("tempfile.swift"))
        XCTAssertTrue(outputFile.contains("output.ll"))
        XCTAssertTrue(FileManager.default.fileExists(atPath: tempFile))
    }
    
    func testValidationFieldSwiftCodeHandlesSmartQuotes() {
        swiftCode = "let x = \"hello\""
        sut = Llvm(
            swiftCode: .constant(swiftCode),
            llvm: .constant(llvm),
            optimizationLevel: .constant(optimizationLevel)
        )
        
        let (tempFile, _) = sut.validationFieldSwiftCode()
        
        let content = try? String(contentsOfFile: tempFile, encoding: .utf8)
        XCTAssertEqual(content, "let x = \"hello\"")
    }
}
