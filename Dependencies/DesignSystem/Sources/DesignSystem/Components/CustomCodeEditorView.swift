//
//  CustomCodeEditorView.swift
//  Theme
//
//  Created by João Lucas on 09/07/25.
//

import SwiftUI
import CodeEditor

/// A reusable view that wraps the `CodeEditor` component for editing source code
/// with syntax highlighting, configurable language, theme, and font size.
public struct CustomCodeEditorView: View {

    @Binding private var source: String

    private var language: CodeEditor.Language
    private var theme: CodeEditor.ThemeName
    private var fontSize: CGFloat

    /// Creates a code editor bound to a string, with the given language and theme.
    ///
    /// - Parameters:
    ///   - source: A binding to the text content displayed and edited in the editor.
    ///   - language: The syntax highlighting language (e.g. `.swift`, `.bash`).
    ///   - theme: The color theme for the editor (e.g. `.atelierSavannaLight`).
    ///   - fontSize: The font size used in the editor. Default is `16`.
    ///
    /// - Usage:
    /// ```swift
    /// @State private var swiftCode = "let x = 42"
    ///
    /// CustomCodeEditorView(
    ///     source: $swiftCode,
    ///     language: .swift,
    ///     theme: .atelierSavannaLight
    /// )
    /// .frame(maxWidth: .infinity)
    /// ```
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
