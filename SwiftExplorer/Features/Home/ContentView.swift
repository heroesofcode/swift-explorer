//
//  ContentView.swift
//  SwiftExplorer
//
//  Created by João Lucas on 22/06/24.
//

import SwiftUI
import CodeEditor

struct ContentView: View {
    @State private var swiftCode: String = ""
    @State private var bytecode: String = ""
    @State private var fontSize: Int = 14

    var body: some View {
        VStack {
            VStack(spacing: 6) {
                HStack {
                    Image(systemName: "swift")
                        .font(.largeTitle)
                        .foregroundColor(Color(hex: "#FA7343"))
                    
                    Text("Swift Explorer")
                        .font(.largeTitle)
                }
                
                Text("Desktop tool to quickly explore and analyze Swift bytecode.")
            }
            
            VStack {
                HStack {
                    Text("Swift")
                        .bold()
                        .font(.title2)
                    
                    Spacer()
                }
                
                CodeEditor(
                    source: $swiftCode,
                    language: .swift,
                    fontSize: .init(get: { CGFloat(16)  },
                                    set: { fontSize = Int($0) }))
                    .border(Color(hex: "#FA7343"), width: 1)
                    .font(.system(size: 100))
                    .frame(maxWidth: .infinity)
            }
            .padding(.top, 16)
            
            Button(action: {
                generateBytecode()
            }) {
                Text("Generate Bytecode")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color(hex: "#FA7343"))
                    .bold()
                    .cornerRadius(8)
            }
            .buttonStyle(PlainButtonStyle())
            .frame(width: 400, height: 30)
            .padding([.top, .bottom], 20)
            
            VStack {
                HStack {
                    Text("Bytecode")
                        .bold()
                        .font(.title2)
                    
                    Spacer()
                }
                
                CodeEditor(
                    source: $bytecode,
                    language: .bash,
                    fontSize: .init(get: { CGFloat(16)  },
                                    set: { fontSize = Int($0) }))
                    .border(Color.blue, width: 1)
            }
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

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        
        if hex.hasPrefix("#") {
            scanner.currentIndex = hex.index(after: hex.startIndex)
        }
        
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let red = (rgbValue & 0xff0000) >> 16
        let green = (rgbValue & 0xff00) >> 8
        let blue = rgbValue & 0xff
        
        self.init(
            .sRGB,
            red: Double(red) / 0xff,
            green: Double(green) / 0xff,
            blue: Double(blue) / 0xff,
            opacity: 1
        )
    }
}
