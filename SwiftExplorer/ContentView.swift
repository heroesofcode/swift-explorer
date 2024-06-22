//
//  ContentView.swift
//  SwiftExplorer
//
//  Created by João Lucas on 22/06/24.
//

import SwiftUI

struct ContentView: View {
    @State private var swiftCode: String = ""
    @State private var bytecode: String = ""

    var body: some View {
        VStack {
            TextEditor(text: $swiftCode)
                .border(Color.gray, width: 1)
                .padding()
            
            Button(action: generateBytecode) {
                Text("Generate Bytecode")
            }
            .padding()
            
            TextEditor(text: $bytecode)
                .border(Color.gray, width: 1)
                .padding()
        }
        .padding()
    }

    func generateBytecode() {
        let tempFile = NSTemporaryDirectory() + "tempfile.swift"
        let outputFile = NSTemporaryDirectory() + "output.s"
        
        let correctedSwiftCode = swiftCode.replacingOccurrences(of: "“", with: "\"")
            .replacingOccurrences(of: "”", with: "\"")
        
        do {
            try correctedSwiftCode.write(toFile: tempFile, atomically: true, encoding: .utf8)
        } catch {
            bytecode = "Error writing temporary file: \(error.localizedDescription)"
            return
        }
        
        let process = Process()
        process.launchPath = "/usr/bin/env"
        process.arguments = ["swiftc", "-emit-assembly", tempFile, "-o", outputFile]
        
        let pipe = Pipe()
        let errorPipe = Pipe()
        process.standardOutput = pipe
        process.standardError = errorPipe
        
        process.launch()
        process.waitUntilExit()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let errorData = errorPipe.fileHandleForReading.readDataToEndOfFile()
        
        let errorOutput = String(data: errorData, encoding: .utf8) ?? ""
        
        print("Error Output: \(errorOutput)")
        
        if !errorOutput.isEmpty {
            bytecode = "Error during script execution: \(errorOutput)"
        } else {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: outputFile))
                bytecode = String(data: data, encoding: .utf8) ?? "Error reading bytecode"
            } catch {
                bytecode = "Error reading output file: \(error.localizedDescription)"
            }
        }
    }

}
