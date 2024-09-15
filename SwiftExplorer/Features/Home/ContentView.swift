//
//  ContentView.swift
//  SwiftExplorer
//
//  Created by João Lucas on 22/06/24.
//

import CodeEditor
import Lowlevel
import SwiftUI
import Theme
import Analytics

struct ContentView: View {
    @State private var swiftCode: String = ""
    @State private var llvm: String = ""
    @State private var assemblyCode: String = ""
    @State private var optimizationLevel: OptimizationLevel = .balanced

    @State private var fontSize: Int = 14
    @State private var showAlert = false
    
    @State private var navigation = NavigationPath()

    var body: some View {
        NavigationStack(path: $navigation) {
            VStack {
                VStack(spacing: 6) {
                    HStack {
                        Image(systemName: "swift")
                            .font(.largeTitle)
                            .foregroundColor(Color(hex: "#FA7343"))

                        Text(L10n.swiftExplorer)
                            .fontLatoBlack(size: 30)
                    }

                    Text(L10n.description)
                        .fontLatoRegular(size: 16)
                }
                .padding(.top, 16)

                HStack {

                    VStack {
                        HStack {
                            Text(L10n.swift)
                                .bold()
                                .fontLatoBold(size: 20)

                            Spacer()
                        }

                        CodeEditor(
                            source: $swiftCode,
                            language: .swift,
                            fontSize: .init(get: { CGFloat(16) },
                                            set: { fontSize = Int($0) })
                        )
                        .border(Color(hex: "#FA7343"), width: 1)
                        .font(.system(size: 100))
                        .frame(maxWidth: .infinity)
                    }
                    VStack {
                        Button {
                            if !swiftCode.isEmpty {
                                let llvm = Llvm(
                                    swiftCode: $swiftCode,
                                    llvm: $llvm,
                                    optimizationLevel: $optimizationLevel
                                )
                                
                                llvm.generateLlvm()

                                assemblyCode = Assembly().generateAssembly(
                                    fromSwiftCode: swiftCode,
                                    optimizationLevel: optimizationLevel
                                )
                                
                                SetAnalyticsEvents.event(AnalyticsEvents.Home.button.rawValue)
                            } else {
                                showAlert = true
                                SetAnalyticsEvents.event(AnalyticsEvents.Home.empty_field.rawValue)
                            }
                        } label: {
                            Text(L10n.generatedButton)
                                .fontLatoBlack(size: 14)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color(hex: "#FA7343"))
                                .cornerRadius(8)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding([.leading, .trailing], 20)
                        .alert(isPresented: $showAlert) {
                            Alert(
                                title: Text(L10n.warning),
                                message: Text(L10n.messageEmptyField),
                                dismissButton: .default(Text(L10n.ok))
                            )
                        }
                        
                        Picker(selection: $optimizationLevel) {
                            Text(OptimizationLevel.balanced.rawValue)
                                .fontLatoRegular(size: 14)
                                .tag(OptimizationLevel.balanced)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color(hex: "#FA7343"))
                                .cornerRadius(8)
                            Text(OptimizationLevel.none.rawValue)
                                .fontLatoRegular(size: 14)
                                .tag(OptimizationLevel.none)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color(hex: "#FA7343"))
                                .cornerRadius(8)
                            Text(OptimizationLevel.size.rawValue)
                                .fontLatoRegular(size: 14)
                                .tag(OptimizationLevel.size)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color(hex: "#FA7343"))
                                .cornerRadius(8)
                            Text(OptimizationLevel.unchecked.rawValue)
                                .fontLatoRegular(size: 14)
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
                        .padding(.top, 16)
                    }

                    VStack {
                        HStack {
                            Text(L10n.llvm)
                                .bold()
                                .fontLatoBold(size: 20)

                            Spacer()
                        }

                        CodeEditor(
                            source: $llvm,
                            language: .bash,
                            fontSize: .init(get: { CGFloat(16) },
                                            set: { fontSize = Int($0) })
                        )
                        .border(Color.blue, width: 1)

                        HStack {
                            Spacer()

                            Button {
                                let pasteboard = NSPasteboard.general
                                pasteboard.clearContents()
                                pasteboard.setString(llvm, forType: .string)
                            } label: {
                                Text(L10n.copy)
                                    .fontLatoBold(size: 14)
                            }
                        }
                    }

                    VStack {
                        HStack {
                            Text(L10n.assembly)
                                .bold()
                                .fontLatoBold(size: 20)

                            Spacer()
                        }

                        CodeEditor(
                            source: $assemblyCode,
                            language: .bash,
                            fontSize: .init(get: { CGFloat(16) },
                                            set: { fontSize = Int($0) })
                        )
                        .border(Color.blue, width: 1)

                        HStack {
                            Spacer()
                            
                            Button {
                                navigation.append(CompareView())
                            } label: {
                                Text("Compare")
                                    .fontLatoBold(size: 14)
                            }

                            Button {
                                let pasteboard = NSPasteboard.general
                                pasteboard.clearContents()
                                pasteboard.setString(assemblyCode, forType: .string)
                            } label: {
                                Text(L10n.copy)
                                    .fontLatoBold(size: 14)
                            }
                        }
                    }
                    .padding(.leading, 20)
                }
                .padding()
            }
            .onAppear {
                SetAnalyticsEvents.event(AnalyticsEvents.Home.view.rawValue)
            }
            .navigationDestination(for: CompareView.self) { view in
                view
            }
        }
    }
}
