import XCTest
import SwiftUI
@testable import Lowlevel

final class LowlevelTests: XCTestCase {
    
    @State private var swiftCode: String = "let a = 10"
    @State private var llvm: String = ""
    @State private var optimizationLevel: OptimizationLevel = .balanced
    
    func testValidationFieldSwiftCode() {
        let bytecodeGenerator = Llvm(
            swiftCode: $swiftCode,
            llvm: $llvm,
            optimizationLevel: $optimizationLevel
        )
        
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
    
    func testGenerateAssembly() {
        let swiftCode = """
        func sum(a: Int, b: Int) -> Int {
            return a + b
        }
        """

        let assemblyCode = Assembly().generateAssembly(
            fromSwiftCode: swiftCode,
            optimizationLevel: optimizationLevel
        )
        
        XCTAssertTrue(assemblyCode.contains("sum"), 
                      "The generated assembly code must contain the 'sum' function.")
        XCTAssertTrue(assemblyCode.contains("ret"), 
                      "The generated assembly code must contain the 'ret' instruction.")
    }

}
