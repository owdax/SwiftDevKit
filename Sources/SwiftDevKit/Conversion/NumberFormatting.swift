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
        roundingRule: NumberFormatter.RoundingMode?
    ) async throws -> String
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
    func formatted() async throws -> String {
        try await formatted(decimals: 2, grouping: true, roundingRule: .halfUp)
    }
}
