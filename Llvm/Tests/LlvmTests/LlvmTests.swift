import XCTest
import SwiftUI
@testable import Llvm

final class LlvmTests: XCTestCase {
    
    @State private var swiftCode: String = "let a = 10"
    @State private var llvm: String = ""
    
    func testValidationFieldSwiftCode() {
        let bytecodeGenerator = Llvm(swiftCode: $swiftCode, llvm: $llvm)
        let (tempFile, outputFile) = bytecodeGenerator.validationFieldSwiftCode()

        XCTAssertTrue(FileManager.default.fileExists(atPath: tempFile), "Temporary Swift file should exist")
        XCTAssertEqual(outputFile, NSTemporaryDirectory() + "output.ll", "Output file path should be correct")
        
        do {
            let content = try String(contentsOfFile: tempFile, encoding: .utf8)
            XCTAssertEqual(content, swiftCode.replacingOccurrences(of: "“", with: "\"")
                .replacingOccurrences(of: "”", with: "\""), "Corrected Swift code should be written to temp file")
        } catch {
            XCTFail("Error reading temporary Swift file: \(error.localizedDescription)")
        }
    }
}
