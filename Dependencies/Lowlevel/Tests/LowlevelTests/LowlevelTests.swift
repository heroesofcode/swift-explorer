import SwiftUI
import XCTest
@testable import Lowlevel

final class LowlevelTests: XCTestCase {

    private var swiftCode: String = "let a = 10"
    private var llvm: String = ""
    private var optimizationLevel: OptimizationLevel = .balanced

    func testValidationFieldSwiftCode() {
        let bytecodeGenerator = Llvm(
            swiftCode: .constant(swiftCode),
            llvm: .constant(llvm),
            optimizationLevel: .constant(optimizationLevel)
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

        XCTAssertTrue(
            assemblyCode.contains("sum"),
            "The generated assembly code must contain the 'sum' function."
        )
        XCTAssertTrue(
            assemblyCode.contains("ret"),
            "The generated assembly code must contain the 'ret' instruction."
        )
    }
    
    func testOptimizationLevelRawValues() {
        XCTAssertEqual(OptimizationLevel.balanced.rawValue, "-O")
        XCTAssertEqual(OptimizationLevel.none.rawValue, "-Onone")
        XCTAssertEqual(OptimizationLevel.size.rawValue, "-Osize")
        XCTAssertEqual(OptimizationLevel.unchecked.rawValue, "-Ounchecked")
    }
    
    func testOptimizationLevelAllCases() {
        XCTAssertEqual(OptimizationLevel.allCases.count, 4)
        XCTAssertTrue(OptimizationLevel.allCases.contains(.balanced))
        XCTAssertTrue(OptimizationLevel.allCases.contains(.none))
        XCTAssertTrue(OptimizationLevel.allCases.contains(.size))
        XCTAssertTrue(OptimizationLevel.allCases.contains(.unchecked))
    }
    
    func testGenerateAssemblyWithDifferentOptimizations() {
        let code = "let x = 42"
        
        let noneAssembly = Assembly().generateAssembly(fromSwiftCode: code, optimizationLevel: .none)
        let sizeAssembly = Assembly().generateAssembly(fromSwiftCode: code, optimizationLevel: .size)
        
        XCTAssertFalse(noneAssembly.isEmpty)
        XCTAssertFalse(sizeAssembly.isEmpty)
    }
}

    func testGenerateAssemblyWithEmptyCode() {
        let assembly = Assembly()
        let result = assembly.generateAssembly(fromSwiftCode: "", optimizationLevel: .balanced)
        XCTAssertFalse(result.isEmpty)
    }
    
    func testGenerateAssemblyWithInvalidCode() {
        let assembly = Assembly()
        let result = assembly.generateAssembly(fromSwiftCode: "invalid @#$ code", optimizationLevel: .balanced)
        XCTAssertTrue(result.contains("Error") || result.contains("error"))
    }
    
    func testGenerateAssemblyWithComplexCode() {
        let assembly = Assembly()
        let code = """
        struct Point {
            var x: Int
            var y: Int
        }
        let p = Point(x: 10, y: 20)
        """
        let result = assembly.generateAssembly(fromSwiftCode: code, optimizationLevel: .balanced)
        XCTAssertFalse(result.isEmpty)
    }
