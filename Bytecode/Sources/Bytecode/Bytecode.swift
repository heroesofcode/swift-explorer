import Foundation
import SwiftUI

public final class Bytecode {
    
    @Binding private var swiftCode: String
    @Binding private var bytecode: String
    
    public init(swiftCode: Binding<String>, bytecode: Binding<String>) {
        self._swiftCode = swiftCode
        self._bytecode = bytecode
    }
    
    public func generateBytecode() {
        let (tempFile, outputFile) = validationFieldSwiftCode()
        
        let pipe = processArgument(tempFile: tempFile, outputFile: outputFile)
        
        let errorData = pipe.fileHandleForReading.readDataToEndOfFile()
        let errorOutput = String(data: errorData, encoding: .utf8) ?? ""
        
        print(L10n.errorOutput(errorOutput))
        
        result(errorOutput: errorOutput, outputFile: outputFile)
    }
    
    internal func validationFieldSwiftCode() -> (String, String) {
        let tempFile = NSTemporaryDirectory() + "tempfile.swift"
        let outputFile = NSTemporaryDirectory() + "output.s"
        
        let correctedSwiftCode = swiftCode.replacingOccurrences(of: "“", with: "\"")
            .replacingOccurrences(of: "”", with: "\"")
        
        do {
            try correctedSwiftCode.write(toFile: tempFile, atomically: true, encoding: .utf8)
        } catch {
            bytecode = L10n.errorWritingTemporary(error.localizedDescription)
            return (tempFile, outputFile)
        }
        
        return (tempFile, outputFile)
    }
    
    private func processArgument(tempFile: String, outputFile: String) -> Pipe {
        let process = Process()
        process.launchPath = "/usr/bin/env"
        process.arguments = ["swiftc", "-emit-assembly", tempFile, "-o", outputFile]
        
        let pipe = Pipe()
        let errorPipe = Pipe()
        process.standardOutput = pipe
        process.standardError = errorPipe
        
        process.launch()
        process.waitUntilExit()
        
        return errorPipe
    }
    
    private func result(errorOutput: String, outputFile: String) {
        if !errorOutput.isEmpty {
            bytecode = L10n.errorScriptExecution(errorOutput)
        } else {
            validationOutputFile(outputFile: outputFile)
        }
    }
    
    private func validationOutputFile(outputFile: String) {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: outputFile))
            bytecode = String(data: data, encoding: .utf8) ?? L10n.errorReadingBytecode
        } catch {
            bytecode = L10n.errorReadingOutput(error.localizedDescription)
        }
    }

}
