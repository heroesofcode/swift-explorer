import Foundation

public final class Assembly {

    public init() {}

    public func generateAssembly(fromSwiftCode swiftCode: String) -> String {
        let tempDirectory = FileManager.default.temporaryDirectory
        let swiftFileURL = tempDirectory.appendingPathComponent("temp.swift")
        let assemblyFileURL = tempDirectory.appendingPathComponent("temp.s")
        
        do {
            try swiftCode.write(to: swiftFileURL, atomically: true, encoding: .utf8)
            
            let process = processArgument(
                assemblyFileURL: assemblyFileURL,
                swiftFileURL: swiftFileURL)
            
            let pipe = Pipe()
            process.standardOutput = pipe
            process.standardError = pipe
            
            try process.run()
            process.waitUntilExit()
            
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            let output = String(data: data, encoding: .utf8) ?? ""
            
            if process.terminationStatus == 0 {
                let assemblyCode = try String(contentsOf: assemblyFileURL, encoding: .utf8)
                return assemblyCode
            } else {
                return L10n.errorAssemblyCode(output)
            }
        } catch {
            return L10n.errorAssemblyCode(error.localizedDescription)
        }
    }
    
    private func processArgument(assemblyFileURL: URL, swiftFileURL: URL) -> Process {
        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/usr/bin/swiftc")
        process.arguments = [
            "-S",
            "-o", assemblyFileURL.path,
            swiftFileURL.path
        ]
        
        return process
    }
}
