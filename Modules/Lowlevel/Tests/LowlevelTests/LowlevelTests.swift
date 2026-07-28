import XCTest
@testable import Lowlevel

final class LowlevelTests: XCTestCase {

    private var swiftCode: String = "let a = 10"
    private var optimizationLevel: OptimizationLevel = .balanced

    func testValidationFieldSwiftCode() {
        let result = Llvm().generateLlvm(
            swiftCode: swiftCode,
            optimizationLevel: optimizationLevel
        )
        
        XCTAssertFalse(result.isEmpty)
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

        let noneAssembly = Assembly().generateAssembly(
            fromSwiftCode: code,
            optimizationLevel: .none
        )
        
        let sizeAssembly = Assembly().generateAssembly(
            fromSwiftCode: code,
            optimizationLevel: .size
        )

        XCTAssertFalse(noneAssembly.isEmpty)
        XCTAssertFalse(sizeAssembly.isEmpty)
    }

    func testGenerateAssemblyWithEmptyCode() {
        let result = Assembly().generateAssembly(
            fromSwiftCode: "",
            optimizationLevel: .balanced
        )
        XCTAssertFalse(result.isEmpty)
    }

    func testGenerateAssemblyWithInvalidCode() {
        let result = Assembly().generateAssembly(
            fromSwiftCode: "invalid @#$ code",
            optimizationLevel: .balanced
        )
        XCTAssertTrue(result.contains("Error") || result.contains("error"))
    }

    func testGenerateAssemblyWithComplexCode() {
        let code = """
        struct Point {
            var x: Int
            var y: Int
        }
        let p = Point(x: 10, y: 20)
        """
        
        let result = Assembly().generateAssembly(
            fromSwiftCode: code,
            optimizationLevel: .balanced
        )
        XCTAssertFalse(result.isEmpty)
    }
}
