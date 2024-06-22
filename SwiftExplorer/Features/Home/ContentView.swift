//
//  ContentView.swift
//  SwiftExplorer
//
//  Created by João Lucas on 22/06/24.
//

import SwiftUI
import CodeEditor
import Bytecode
import Theme

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
                    
                    Text(L10n.swiftExplorer)
                        .font(.largeTitle)
                }
                
                Text(L10n.description)
            }
            
            VStack {
                HStack {
                    Text(L10n.swift)
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
                Text(L10n.generatedBytecode)
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
                    Text(L10n.bytecode)
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
