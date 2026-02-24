//
//  HomeViewModelTests.swift
//  SwiftExplorer
//
//  Created by João Lucas on 22/02/26.
//

import XCTest
import Lowlevel
@testable import SwiftExplorer

final class HomeViewModelTests: XCTestCase {
    
    var sut: HomeViewModel!
    
    override func setUp() {
        super.setUp()
        sut = HomeViewModel()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testInitialState() {
        XCTAssertEqual(sut.swiftCode, "")
        XCTAssertEqual(sut.llvm, "")
        XCTAssertEqual(sut.assemblyCode, "")
        XCTAssertEqual(sut.optimizationLevel, .balanced)
        XCTAssertFalse(sut.showAlert)
    }
    
    func testTapGenerateWithEmptyCode() {
        let llvm = Llvm(
            swiftCode: .constant(""),
            llvm: .constant(""),
            optimizationLevel: .constant(.balanced)
        )
        
        sut.tapGenerate(llvm: llvm)
        
        XCTAssertTrue(sut.showAlert)
        XCTAssertEqual(sut.assemblyCode, "")
    }
    
    func testTapGenerateWithValidCode() {
        sut.swiftCode = "let x = 5"
        
        let llvm = Llvm(
            swiftCode: .constant(sut.swiftCode),
            llvm: .constant(sut.llvm),
            optimizationLevel: .constant(sut.optimizationLevel)
        )
        
        sut.tapGenerate(llvm: llvm)
        
        XCTAssertFalse(sut.showAlert)
        XCTAssertFalse(sut.assemblyCode.isEmpty)
    }
    
    func testOptimizationLevelChange() {
        sut.optimizationLevel = .none
        XCTAssertEqual(sut.optimizationLevel, .none)
        
        sut.optimizationLevel = .size
        XCTAssertEqual(sut.optimizationLevel, .size)
        
        sut.optimizationLevel = .unchecked
        XCTAssertEqual(sut.optimizationLevel, .unchecked)
        
        sut.optimizationLevel = .balanced
        XCTAssertEqual(sut.optimizationLevel, .balanced)
    }
    
    func testOnAppear() {
        sut.onAppear()
        XCTAssertNotNil(sut)
    }
    
    func testSwiftCodeBinding() {
        sut.swiftCode = "func test() {}"
        XCTAssertEqual(sut.swiftCode, "func test() {}")
    }
    
    func testLlvmBinding() {
        sut.llvm = "define void @main()"
        XCTAssertEqual(sut.llvm, "define void @main()")
    }
    
    func testAssemblyCodeBinding() {
        sut.assemblyCode = ".section __TEXT"
        XCTAssertEqual(sut.assemblyCode, ".section __TEXT")
    }
    
    func testShowAlertToggle() {
        XCTAssertFalse(sut.showAlert)
        sut.showAlert = true
        XCTAssertTrue(sut.showAlert)
    }
    
    func testTapGenerateWithNonEmptyCodeUpdatesAssembly() {
        sut.swiftCode = "let y = 10"
        let initialAssembly = sut.assemblyCode
        
        let llvm = Llvm(
            swiftCode: .constant(sut.swiftCode),
            llvm: .constant(sut.llvm),
            optimizationLevel: .constant(sut.optimizationLevel)
        )
        
        sut.tapGenerate(llvm: llvm)
        
        XCTAssertNotEqual(sut.assemblyCode, initialAssembly)
    }
    
    func testMultipleOptimizationLevelChanges() {
        let levels: [OptimizationLevel] = [.none, .balanced, .size, .unchecked, .balanced]
        
        for level in levels {
            sut.optimizationLevel = level
            XCTAssertEqual(sut.optimizationLevel, level)
        }
    }
}
