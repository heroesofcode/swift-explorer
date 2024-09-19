//
//  CompareView.swift
//  SwiftExplorer
//
//  Created by João Lucas on 15/09/24.
//

import SwiftUI
import Theme
import Gemini

struct CompareView<ViewModel: CompareViewModelProtocol>: View, Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(1)
    }
    
    static func == (lhs: CompareView, rhs: CompareView) -> Bool {
        return true
    }
    
    @State private var apiKey: String = ""
    @ObservedObject var viewModel: ViewModel
    
    private let swiftCode: String
    private let llvmCode: String
    private let assemblyCode: String
    
    init(
        swiftCode: String,
        llvmCode: String,
        assemblyCode: String,
        viewModel: ViewModel = CompareViewModel()) {
        self.swiftCode = swiftCode
        self.llvmCode = llvmCode
        self.assemblyCode = assemblyCode
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(L10n.titleCompareView)
                        .fontLatoBlack(size: 18)
                        .padding([.leading, .top], 16)
                    
                    Spacer()
                }
                
                HStack {
                    TextField(L10n.enterTheApiKeyGemini, text: $apiKey)
                        .padding()
                        .frame(width: 400, height: 40)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .shadow(radius: 2)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding(.leading, 16)
                    
                    Button {
                        viewModel.resultGemini(
                            apiKey: apiKey,
                            swiftCode: swiftCode,
                            llvmCode: llvmCode,
                            assemblyCode: assemblyCode
                        )
                    } label: {
                        Text(L10n.review)
                            .fontLatoBlack(size: 14)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color(hex: "#FA7343"))
                            .cornerRadius(8)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            
            HStack {
                Spacer()
                
                Button {
                    let pasteboard = NSPasteboard.general
                    pasteboard.clearContents()
                    pasteboard.setString(viewModel.resultText, forType: .string)
                } label: {
                    Text(L10n.copy)
                        .fontLatoBold(size: 14)
                }
            }
            .padding(.trailing)
            
            ZStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: .infinity)
                    .cornerRadius(12)
                    .overlay(
                        ScrollView {
                            HStack {
                                Text(viewModel.resultText)
                                    .fontLatoRegular(size: 16)
                                    .padding()
                                
                                Spacer()
                            }
                        }
                    )
            }
            .padding()
            
            Spacer()
        }
        .navigationTitle(L10n.details)
    }
}
