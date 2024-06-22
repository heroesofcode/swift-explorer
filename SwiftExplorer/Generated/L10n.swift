// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Bytecode
  internal static let bytecode = L10n.tr("SwiftExplorer", "bytecode", fallback: "Bytecode")
  /// Desktop tool to quickly explore and analyze Swift bytecode.
  internal static let description = L10n.tr("SwiftExplorer", "description", fallback: "Desktop tool to quickly explore and analyze Swift bytecode.")
  /// Generate Bytecode
  internal static let generatedBytecode = L10n.tr("SwiftExplorer", "generatedBytecode", fallback: "Generate Bytecode")
  /// Swift
  internal static let swift = L10n.tr("SwiftExplorer", "swift", fallback: "Swift")
  /// SwiftExplorer.strings
  ///   SwiftExplorer
  /// 
  ///   Created by João Lucas on 22/06/24.
  internal static let swiftExplorer = L10n.tr("SwiftExplorer", "swiftExplorer", fallback: "Swift Explorer")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
