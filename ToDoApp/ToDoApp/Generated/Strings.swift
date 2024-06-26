// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum T {
  /// arrow.down
  internal static let arrowDown = T.tr("Localizable-ru", "arrowDown", fallback: "arrow.down")
  /// Отменить
  internal static let cancel = T.tr("Localizable-ru", "Cancel", fallback: "Отменить")
  /// Удалить
  internal static let delete = T.tr("Localizable-ru", "Delete", fallback: "Удалить")
  /// Сделать до
  internal static let doBefore = T.tr("Localizable-ru", "DoBefore", fallback: "Сделать до")
  /// exclamationmark.2
  internal static let exclamationMark = T.tr("Localizable-ru", "exclamationMark", fallback: "exclamationmark.2")
  /// Важность
  internal static let importance = T.tr("Localizable-ru", "Importance", fallback: "Важность")
  /// Дело
  internal static let item = T.tr("Localizable-ru", "Item", fallback: "Дело")
  /// Нет
  internal static let no = T.tr("Localizable-ru", "No", fallback: "Нет")
  /// plus
  internal static let plus = T.tr("Localizable-ru", "plus", fallback: "plus")
  /// Сохранить
  internal static let save = T.tr("Localizable-ru", "Save", fallback: "Сохранить")
  /// Что надо сделать?
  internal static let whatNeedToDo = T.tr("Localizable-ru", "What need to do", fallback: "Что надо сделать?")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension T {
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
