// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Error generating assembly code: %@
  internal static func errorAssemblyCode(_ p1: Any) -> String {
    return L10n.tr("Lowlevel", "errorAssemblyCode", String(describing: p1), fallback: "Error generating assembly code: %@")
  }
  /// Bytecode.strings
  ///   
  /// 
  ///   Created by João Lucas on 22/06/24.
  internal static func errorOutput(_ p1: Any) -> String {
    return L10n.tr("Lowlevel", "errorOutput", String(describing: p1), fallback: "Error Output: %@")
  }
  /// Error reading bytecode
  internal static let errorReadingBytecode = L10n.tr("Lowlevel", "errorReadingBytecode", fallback: "Error reading bytecode")
  /// Error reading output file: %@
  internal static func errorReadingOutput(_ p1: Any) -> String {
    return L10n.tr("Lowlevel", "errorReadingOutput", String(describing: p1), fallback: "Error reading output file: %@")
  }
  /// Error during script execution %@
  internal static func errorScriptExecution(_ p1: Any) -> String {
    return L10n.tr("Lowlevel", "errorScriptExecution", String(describing: p1), fallback: "Error during script execution %@")
  }
  /// Error writing temporary file: %@
  internal static func errorWritingTemporary(_ p1: Any) -> String {
    return L10n.tr("Lowlevel", "errorWritingTemporary", String(describing: p1), fallback: "Error writing temporary file: %@")
  }
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
