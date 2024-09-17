//
//  CompareView.swift
//  SwiftExplorer
//
//  Created by João Lucas on 15/09/24.
//

import SwiftUI
import Theme
import Gemini

struct CompareView: View, Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(1)
    }
    
    static func == (lhs: CompareView, rhs: CompareView) -> Bool {
        return true
    }
    
    @State private var apiKey: String = ""
    @State private var resultText: String = ""
    
    private let swiftCode: String
    private let llvmCode: String
    private let assemblyCode: String
    
    init(swiftCode: String, llvmCode: String, assemblyCode: String) {
        self.swiftCode = swiftCode
        self.llvmCode = llvmCode
        self.assemblyCode = assemblyCode
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("Review the details of the generated LVVM and Assembly")
                        .fontLatoBlack(size: 18)
                        .padding([.leading, .top], 16)
                    
                    Spacer()
                }
                
                HStack {
                    TextField("Enter the API Key Gemini", text: $apiKey)
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
                        Task {
                            await comparationCode(apiKey: apiKey)
                        }
                    } label: {
                        Text("Review")
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
                    pasteboard.setString(resultText, forType: .string)
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
                                Text(resultText)
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
        .navigationTitle("Details")
    }
    
    private func comparationCode(apiKey: String) async {
        await APIGemini().result(
            apiKey: apiKey, 
            code: swiftCode,
            llvmCode: llvmCode,
            assemblyCode: assemblyCode) { result in
                switch result {
                case .success(let text):
                    self.resultText = text
                case .failure(let error):
                    print(error)
                }
            }
    }
}
