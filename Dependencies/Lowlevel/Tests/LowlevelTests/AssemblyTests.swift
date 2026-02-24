//
//  AssemblyTests.swift
//  Lowlevel
//
//  Created by João Lucas on 22/02/26.
//

import XCTest
@testable import Lowlevel

final class AssemblyTests: XCTestCase {
    
    var sut: Assembly!
    
    override func setUp() {
        super.setUp()
        sut = Assembly()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testGenerateAssemblyWithValidCode() {
        let result = sut.generateAssembly(
            fromSwiftCode: "let x = 5",
            optimizationLevel: .balanced
        )
        
        XCTAssertFalse(result.isEmpty)
        XCTAssertTrue(result.contains(".section"))
    }
    
    func testGenerateAssemblyWithInvalidCode() {
        let result = sut.generateAssembly(
            fromSwiftCode: "invalid swift code @#$",
            optimizationLevel: .balanced
        )
        
        XCTAssertTrue(result.contains("Error"))
    }
    
    func testGenerateAssemblyWithEmptyCode() {
        let result = sut.generateAssembly(
            fromSwiftCode: "",
            optimizationLevel: .balanced
        )
        
        XCTAssertFalse(result.isEmpty)
    }
    
    func testGenerateAssemblyWithDifferentOptimizationLevels() {
        let code = "func test() -> Int { return 42 }"
        
        let noneResult = sut.generateAssembly(fromSwiftCode: code, optimizationLevel: .none)
        let balancedResult = sut.generateAssembly(fromSwiftCode: code, optimizationLevel: .balanced)
        let sizeResult = sut.generateAssembly(fromSwiftCode: code, optimizationLevel: .size)
        
        XCTAssertFalse(noneResult.isEmpty)
        XCTAssertFalse(balancedResult.isEmpty)
        XCTAssertFalse(sizeResult.isEmpty)
    }
}
