//
//  ContentView.swift
//  SwiftExplorer
//
//  Created by João Lucas on 22/06/24.
//

import SwiftUI
import CodeEditor
import Lowlevel
import Theme

struct ContentView: View {
    @State private var swiftCode: String = ""
    @State private var llvm: String = ""
    @State private var assemblyCode: String = ""
    @State private var optimizationLevel: OptimizationLevel = .balanced
    
    @State private var fontSize: Int = 14
    @State private var showAlert = false

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
            .padding(.top, 16)
            
            HStack {
                
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
                VStack {
                    Button {
                        if !swiftCode.isEmpty {
                            let llvm = Llvm(swiftCode: $swiftCode, llvm: $llvm, optimizationLevel: $optimizationLevel)
                            llvm.generateLlvm()
                            
                            assemblyCode = Assembly().generateAssembly(fromSwiftCode: swiftCode, optimizationLevel: optimizationLevel)
                        } else {
                            showAlert = true
                        }
                    } label: {
                        Text(L10n.generatedButton)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color(hex: "#FA7343"))
                            .bold()
                            .cornerRadius(8)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding([.leading, .trailing], 20)
                    Picker(selection: $optimizationLevel) {
                        Text(OptimizationLevel.balanced.rawValue)
                            .tag(OptimizationLevel.balanced)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color(hex: "#FA7343"))
                            .cornerRadius(8)
                        Text(OptimizationLevel.none.rawValue)
                            .tag(OptimizationLevel.none)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color(hex: "#FA7343"))
                            .cornerRadius(8)
                        Text(OptimizationLevel.size.rawValue)
                            .tag(OptimizationLevel.size)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color(hex: "#FA7343"))
                            .cornerRadius(8)
                        Text(OptimizationLevel.unchecked.rawValue)
                            .tag(OptimizationLevel.unchecked)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color(hex: "#FA7343"))
                            .cornerRadius(8)
                    } label: {
                        EmptyView()
                    }
                    .pickerStyle(.segmented)
                    .padding([.leading, .trailing], 20)
                }
                
                VStack {
                    HStack {
                        Text(L10n.llvm)
                            .bold()
                            .font(.title2)
                        
                        Spacer()
                    }
                    
                    CodeEditor(
                        source: $llvm,
                        language: .bash,
                        fontSize: .init(get: { CGFloat(16)  },
                                        set: { fontSize = Int($0) }))
                        .border(Color.blue, width: 1)
                    
                    HStack {
                        Spacer()
                        
                        Button {
                            let pasteboard = NSPasteboard.general
                            pasteboard.clearContents()
                            pasteboard.setString(llvm, forType: .string)
                        } label: {
                            Text(L10n.copy)
                        }
                    }
                }
                
                VStack {
                    HStack {
                        Text(L10n.assembly)
                            .bold()
                            .font(.title2)
                        
                        Spacer()
                    }
                    
                    CodeEditor(
                        source: $assemblyCode,
                        language: .bash,
                        fontSize: .init(get: { CGFloat(16)  },
                                        set: { fontSize = Int($0) }))
                        .border(Color.blue, width: 1)
                    
                    HStack {
                        Spacer()
                        
                        Button {
                            let pasteboard = NSPasteboard.general
                            pasteboard.clearContents()
                            pasteboard.setString(assemblyCode, forType: .string)
                        } label: {
                            Text(L10n.copy)
                        }
                    }
                }
                .padding(.leading, 20)
            }
            .padding()
        }
    }
}
