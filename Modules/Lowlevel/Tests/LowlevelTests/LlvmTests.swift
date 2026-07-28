//
//  LlvmTests.swift
//  Lowlevel
//
//  Created by João Lucas on 22/02/26.
//

import XCTest
@testable import Lowlevel

final class LlvmTests: XCTestCase {

    var sut: Llvm!

    override func setUp() {
        super.setUp()
        sut = Llvm()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testGenerateLlvmWritesTempFile() {
        _ = sut.generateLlvm(swiftCode: "let x = 5", optimizationLevel: .balanced)

        let tempFile = NSTemporaryDirectory() + "tempfile.swift"
        XCTAssertTrue(FileManager.default.fileExists(atPath: tempFile))
    }

    func testGenerateLlvmNormalizesSmartQuotes() {
        _ = sut.generateLlvm(swiftCode: "\u{201C}hello\u{201D}", optimizationLevel: .balanced)

        let tempFile = NSTemporaryDirectory() + "tempfile.swift"
        let content = try? String(contentsOfFile: tempFile, encoding: .utf8)
        XCTAssertEqual(content, "\"hello\"")
    }

    func testGenerateLlvmWithValidCodeReturnsNonEmptyResult() {
        let result = sut.generateLlvm(swiftCode: "let x = 5", optimizationLevel: .balanced)
        XCTAssertFalse(result.isEmpty)
    }
}
