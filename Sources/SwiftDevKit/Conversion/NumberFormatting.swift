// NumberFormatting.swift
// SwiftDevKit
//
// Copyright (c) 2025 owdax and The SwiftDevKit Contributors
// MIT License - https://opensource.org/licenses/MIT

import Foundation

/// A type that can be formatted as a number string with various options.
///
/// This protocol provides a standardized way to format numbers with common options like
/// decimal places, grouping separators, and rounding rules.
///
/// Example usage:
/// ```swift
/// let number = 1234.5678
/// // Basic formatting
/// let formatted = try number.formatted(decimals: 2) // "1,234.57"
/// // Without grouping
/// let plain = try number.formatted(decimals: 2, grouping: false) // "1234.57"
/// ```
public protocol NumberFormattable {
    /// Formats the number with specified options.
    ///
    /// - Parameters:
    ///   - decimals: Number of decimal places (default: 2)
    ///   - grouping: Whether to use grouping separators (default: true)
    ///   - roundingRule: The rounding rule to apply (default: .toNearestOrEven)
    /// - Returns: A formatted string representation
    /// - Throws: `NumberFormattingError` if formatting fails
    func formatted(
        decimals: Int?,
        grouping: Bool?,
        roundingRule: NumberFormatter.RoundingMode?) throws -> String

    /// Formats the number as a percentage.
    ///
    /// - Parameters:
    ///   - decimals: Number of decimal places (default: 2)
    ///   - locale: The locale to use for formatting (default: current)
    /// - Returns: A formatted percentage string (e.g., "42.5%")
    /// - Throws: `NumberFormattingError` if formatting fails
    func asPercentage(
        decimals: Int?,
        locale: Locale?) throws -> String

    /// Formats the number as currency.
    ///
    /// - Parameters:
    ///   - code: The ISO 4217 currency code (e.g., "USD", "EUR")
    ///   - locale: The locale to use for formatting (default: current)
    /// - Returns: A formatted currency string (e.g., "$1,234.56")
    /// - Throws: `NumberFormattingError` if formatting fails
    func asCurrency(
        code: String,
        locale: Locale?) throws -> String

    /// Formats the number in scientific notation.
    ///
    /// - Parameters:
    ///   - decimals: Number of decimal places (default: 2)
    ///   - locale: The locale to use for formatting (default: current)
    /// - Returns: A scientific notation string (e.g., "1.23E4")
    /// - Throws: `NumberFormattingError` if formatting fails
    func asScientific(
        decimals: Int?,
        locale: Locale?) throws -> String

    /// Formats the number as an ordinal.
    ///
    /// - Parameters:
    ///   - locale: The locale to use for formatting (default: current)
    /// - Returns: An ordinal string (e.g., "1st", "2nd", "3rd", "4th")
    /// - Throws: `NumberFormattingError` if formatting fails
    func asOrdinal(
        locale: Locale?) throws -> String

    /// Spells out the number in words.
    ///
    /// - Parameters:
    ///   - locale: The locale to use for formatting (default: current)
    ///   - capitalized: Whether to capitalize the first word (default: false)
    /// - Returns: The number spelled out in words (e.g., "one thousand two hundred thirty-four")
    /// - Throws: `NumberFormattingError` if formatting fails
    func asWords(
        locale: Locale?,
        capitalized: Bool?
    ) throws -> String
}

/// Errors that can occur during number formatting operations.
public enum NumberFormattingError: Error, LocalizedError, Equatable {
    /// The number is invalid for the requested format.
    case invalidNumber(String)
    /// The formatting options are invalid.
    case invalidOptions(String)
    /// A custom error with a specific message.
    case custom(String)

    public var errorDescription: String? {
        switch self {
            case let .invalidNumber(value):
                "Invalid number for formatting: \(value)"
            case let .invalidOptions(message):
                "Invalid formatting options: \(message)"
            case let .custom(message):
                message
        }
    }
}

// MARK: - Default Implementation

public extension NumberFormattable {
    /// Formats the number using default options.
    ///
    /// Default formatting uses:
    /// - 2 decimal places
    /// - Grouping separators enabled
    /// - Rounds to nearest or even
    ///
    /// - Returns: A formatted string representation
    /// - Throws: `NumberFormattingError` if formatting fails
    func formatted() throws -> String {
        try formatted(decimals: 2, grouping: true, roundingRule: .halfUp)
    }

    func asPercentage(
        decimals: Int? = 2,
        locale: Locale? = .current) throws -> String
    {
        guard let number = self as? NSNumber else {
            throw NumberFormattingError.invalidNumber("Value cannot be converted to a number")
        }

        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.locale = locale ?? .current
        formatter.maximumFractionDigits = decimals ?? 2
        formatter.minimumFractionDigits = decimals ?? 2

        guard let result = formatter.string(from: number) else {
            throw NumberFormattingError.invalidNumber("Could not format as percentage")
        }
        return result
    }

    func asCurrency(
        code: String,
        locale: Locale? = .current) throws -> String
    {
        guard let number = self as? NSNumber else {
            throw NumberFormattingError.invalidNumber("Value cannot be converted to a number")
        }

        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = locale ?? .current
        formatter.currencyCode = code

        guard let result = formatter.string(from: number) else {
            throw NumberFormattingError.invalidNumber("Could not format as currency")
        }
        return result
    }

    func asScientific(
        decimals: Int? = 2,
        locale: Locale? = .current) throws -> String
    {
        guard let number = self as? NSNumber else {
            throw NumberFormattingError.invalidNumber("Value cannot be converted to a number")
        }

        let formatter = NumberFormatter()
        formatter.numberStyle = .scientific
        formatter.locale = locale ?? .current
        formatter.maximumFractionDigits = decimals ?? 2
        formatter.minimumFractionDigits = decimals ?? 2

        guard let result = formatter.string(from: number) else {
            throw NumberFormattingError.invalidNumber("Could not format as scientific notation")
        }
        return result
    }

    func asOrdinal(
        locale: Locale? = .current) throws -> String
    {
        guard let number = self as? NSNumber else {
            throw NumberFormattingError.invalidNumber("Value cannot be converted to a number")
        }

        let formatter = NumberFormatter()
        formatter.numberStyle = .ordinal
        formatter.locale = locale ?? .current

        guard let result = formatter.string(from: number) else {
            throw NumberFormattingError.invalidNumber("Could not format as ordinal")
        }
        return result
    }

    func asWords(
        locale: Locale? = .current,
        capitalized: Bool? = false
    ) throws -> String {
        guard let number = self as? NSNumber else {
            throw NumberFormattingError.invalidNumber("Value cannot be converted to a number")
        }

        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        formatter.locale = locale ?? .current

        guard var result = formatter.string(from: number) else {
            throw NumberFormattingError.invalidNumber("Could not spell out number")
        }

        if capitalized ?? false {
            result = result.prefix(1).uppercased() + result.dropFirst()
        }
        return result
    }
}
