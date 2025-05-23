import Foundation
import SwiftUI

/// A class responsible for generating LLVM IR from Swift source code using `swiftc`.
public final class Llvm {

    @Binding private var swiftCode: String
    @Binding private var llvm: String
    @Binding private var optimizationLevel: OptimizationLevel

    /// Initializes a new instance of `Llvm`.
    ///
    /// - Parameters:
    ///   - swiftCode: A binding to the Swift source code input.
    ///   - llvm: A binding to store the resulting LLVM IR.
    ///   - optimizationLevel: A binding that defines the optimization level to use during compilation.
    public init(
        swiftCode: Binding<String>,
        llvm: Binding<String>,
        optimizationLevel: Binding<OptimizationLevel>
    ) {
        _swiftCode = swiftCode
        _llvm = llvm
        _optimizationLevel = optimizationLevel
    }

    /// Generates LLVM IR from the provided Swift code.
    ///
    /// This method writes the Swift code to a temporary file,
    /// invokes `swiftc` with the `-emit-ir` flag, and stores the output or error in the `llvm` binding.
    public func generateLlvm() {
        let (tempFile, outputFile) = validationFieldSwiftCode()

        let pipe = processArgument(
            tempFile: tempFile,
            outputFile: outputFile,
            optimizationLevel: optimizationLevel
        )

        let errorData = pipe.fileHandleForReading.readDataToEndOfFile()
        let errorOutput = String(data: errorData, encoding: .utf8) ?? ""

        print(L10n.errorOutput(errorOutput))

        result(errorOutput: errorOutput, outputFile: outputFile)
    }

    func validationFieldSwiftCode() -> (String, String) {
        let tempFile = NSTemporaryDirectory() + "tempfile.swift"
        let outputFile = NSTemporaryDirectory() + "output.ll"

        let correctedSwiftCode = swiftCode.replacingOccurrences(of: "“", with: "\"")
            .replacingOccurrences(of: "”", with: "\"")

        do {
            try correctedSwiftCode.write(toFile: tempFile, atomically: true, encoding: .utf8)
        } catch {
            llvm = L10n.errorWritingTemporary(error.localizedDescription)
            return (tempFile, outputFile)
        }

        return (tempFile, outputFile)
    }

    private func processArgument(
        tempFile: String,
        outputFile: String,
        optimizationLevel: OptimizationLevel
    ) -> Pipe {
        let process = Process()
        process.launchPath = "/usr/bin/env"
        process.arguments = [
            "swiftc",
            "-emit-ir",
            tempFile,
            "-o",
            outputFile,
            optimizationLevel.rawValue
        ]

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
            llvm = L10n.errorScriptExecution(errorOutput)
        } else {
            validationOutputFile(outputFile: outputFile)
        }
    }

    private func validationOutputFile(outputFile: String) {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: outputFile))
            llvm = String(data: data, encoding: .utf8) ?? L10n.errorReadingBytecode
        } catch {
            llvm = L10n.errorReadingOutput(error.localizedDescription)
        }
    }
}
