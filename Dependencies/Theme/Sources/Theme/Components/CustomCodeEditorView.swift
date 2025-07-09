//
//  CustomCodeEditorView.swift
//  Theme
//
//  Created by João Lucas on 09/07/25.
//

import SwiftUI
import CodeEditor

/// A reusable `View` that wraps the `CodeEditor` component,
/// allowing easy configuration of the source code, language, theme, and font size.
///
/// - Parameters:
///   - source: The text content displayed and edited in the editor.
///   - language: The syntax highlighting language. Default is `.swift`.
///   - theme: The color theme applied to the editor. Default is `.atelierSavannaLight`.
///   - fontSize: The font size used in the editor. Default is `16`.
public struct CustomCodeEditorView: View {
    
    @Binding private var source: String
    
    private var language: CodeEditor.Language
    private var theme: CodeEditor.ThemeName
    private var fontSize: CGFloat

    /// Initializes a new instance of `CustomCodeEditorView`.
    ///
    /// - Parameters:
    ///   - source: A binding to the editor's content.
    ///   - language: The syntax highlighting language (e.g., `.swift`, `.c`, `.python`).
    ///   - theme: The visual theme of the editor.
    ///   - fontSize: The font size used in the editor.
    public init(
        source: Binding<String>,
        language: CodeEditor.Language,
        theme: CodeEditor.ThemeName,
        fontSize: CGFloat = 16
    ) {
        self._source = source
        self.language = language
        self.theme = theme
        self.fontSize = fontSize
    }

    public var body: some View {
        CodeEditor(
            source: $source,
            language: language,
            theme: theme,
            fontSize: .init(
                get: { fontSize },
                set: { _ in }
            )
        )
    }
    
}
