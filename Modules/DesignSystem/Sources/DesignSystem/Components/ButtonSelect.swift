//
//  ButtonSelect.swift
//  DesignSystem
//
//  Created by João Lucas on 08/03/26.
//

import SwiftUI

/// A select-style button that shows a popover with custom content when tapped.
///
/// Use ``ButtonSelect`` for dropdown-like controls where the user picks an option or triggers
/// an action from a list. The label is shown on the button; the content is shown in a popover
/// and receives a dismiss closure so the popover can be closed when a choice is made.
///
/// ## Usage
///
/// ```swift
/// ButtonSelect(
///     label: { Text("Theme") },
///     content: { dismiss in
///         VStack {
///             Button("Light") { /* apply */; dismiss() }
///             Button("Dark") { /* apply */; dismiss() }
///         }
///     }
/// )
/// ```
///
/// With a custom background color:
///
/// ```swift
/// ButtonSelect(
///     backgroundColor: .themeControlBackground,
///     label: { Text("Language") },
///     content: { dismiss in
///         Picker(selection: $language, label: EmptyView()) { ... }
///             .onChange(of: language) { _, _ in dismiss() }
///     }
/// )
/// ```
public struct ButtonSelect<Label: View, Content: View>: View {

    @State private var isPopoverPresented = false
    private let label: Label
    private let content: (@escaping () -> Void) -> Content
    private let backgroundColor: Color

    /// Creates a select button with a custom label and popover content.
    ///
    /// - Parameters:
    ///   - backgroundColor: Background color of the button. Defaults to ``Color/themeControlBackground``.
    ///   - label: A view builder that produces the label shown on the button (e.g. current selection or title).
    ///   - content: A view builder that produces the popover content. Receives a `dismiss` closure;
    ///     call it to close the popover (e.g. when the user selects an option).
    public init(
        backgroundColor: Color = .themeControlBackground,
        @ViewBuilder label: () -> Label,
        @ViewBuilder content: @escaping (@escaping () -> Void) -> Content
    ) {
        self.backgroundColor = backgroundColor
        self.label = label()
        self.content = content
    }

    public var body: some View {
        Button {
            isPopoverPresented = true
        } label: {
            selectLabel
        }
        .buttonStyle(.plain)
        .popover(isPresented: $isPopoverPresented) {
            content({ isPopoverPresented = false })
                .padding(8)
                .frame(minWidth: 120)
        }
    }

    private var selectLabel: some View {
        HStack(spacing: 0) {
            label
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 8)

            SFSymbol.chevronDown
                .font(.system(size: 10, weight: .semibold))
                .foregroundColor(.themeWhite)
                .frame(width: 26, height: 22)
                .cornerRadius(8)
                .padding(.trailing, 6)
                .padding(.vertical, 4)
        }
        .padding(.vertical, 4)
        .background(backgroundColor)
        .cornerRadius(6)
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .stroke(Color.themeSeparator, lineWidth: 0.5)
        )
    }
}
