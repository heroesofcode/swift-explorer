import XCTest
import SwiftUI
@testable import Bytecode

final class BytecodeTests: XCTestCase {
    
    @State private var swiftCode: String = "let a = 10"
    @State private var bytecode: String = ""
    
    func testValidationFieldSwiftCode() {
        let bytecodeGenerator = Bytecode(swiftCode: $swiftCode, bytecode: $bytecode)
        let (tempFile, outputFile) = bytecodeGenerator.validationFieldSwiftCode()

        XCTAssertTrue(FileManager.default.fileExists(atPath: tempFile), "Temporary Swift file should exist")
        XCTAssertEqual(outputFile, NSTemporaryDirectory() + "output.s", "Output file path should be correct")
        
        do {
            let content = try String(contentsOfFile: tempFile, encoding: .utf8)
            XCTAssertEqual(content, swiftCode.replacingOccurrences(of: "“", with: "\"")
                .replacingOccurrences(of: "”", with: "\""), "Corrected Swift code should be written to temp file")
        } catch {
            XCTFail("Error reading temporary Swift file: \(error.localizedDescription)")
        }
    }
}
