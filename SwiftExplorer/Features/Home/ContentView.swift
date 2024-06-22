//
//  ContentView.swift
//  SwiftExplorer
//
//  Created by João Lucas on 22/06/24.
//

import SwiftUI
import CodeEditor
import Bytecode

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
                let bytecode = Bytecode(swiftCode: $swiftCode, bytecode: $bytecode)
                bytecode.generateBytecode()
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
