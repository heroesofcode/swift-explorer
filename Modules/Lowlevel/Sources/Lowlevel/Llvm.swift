import Foundation

/// A class responsible for generating LLVM IR from Swift source code using `swiftc`.
public final class Llvm {

    public init() {}

    /// Generates LLVM IR from the provided Swift code.
    ///
    /// - Parameters:
    ///   - swiftCode: The Swift source code to compile.
    ///   - optimizationLevel: The optimization level to apply during compilation.
    /// - Returns: A string containing the LLVM IR or an error message.
    public func generateLlvm(swiftCode: String, optimizationLevel: OptimizationLevel) -> String {
        let tempFile = NSTemporaryDirectory() + "tempfile.swift"
        let outputFile = NSTemporaryDirectory() + "output.ll"

        let normalizedCode = swiftCode
            .replacingOccurrences(of: "\u{201C}", with: "\"")
            .replacingOccurrences(of: "\u{201D}", with: "\"")

        do {
            try normalizedCode.write(toFile: tempFile, atomically: true, encoding: .utf8)
        } catch {
            return L10n.errorWritingTemporary(error.localizedDescription)
        }

        let errorPipe = processArgument(
            tempFile: tempFile,
            outputFile: outputFile,
            optimizationLevel: optimizationLevel
        )

        let errorData = errorPipe.fileHandleForReading.readDataToEndOfFile()
        let errorOutput = String(data: errorData, encoding: .utf8) ?? ""

        guard errorOutput.isEmpty else {
            return L10n.errorScriptExecution(errorOutput)
        }

        return readOutputFile(at: outputFile)
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

    private func readOutputFile(at path: String) -> String {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            return String(data: data, encoding: .utf8) ?? L10n.errorReadingBytecode
        } catch {
            return L10n.errorReadingOutput(error.localizedDescription)
        }
    }
}
