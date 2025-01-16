// DateConvertible.swift
// SwiftDevKit
//
// Copyright (c) 2025 owdax and The SwiftDevKit Contributors
// MIT License - https://opensource.org/licenses/MIT

import Foundation

/// A type that can be converted to and from date representations.
/// This protocol provides date-specific conversion capabilities with thread-safe operations.
public protocol DateConvertible {
    /// Converts the instance to a date string using the specified format.
    ///
    /// - Parameter format: The date format to use. If nil, uses ISO8601 format.
    /// - Returns: A string representation of the date.
    /// - Throws: `DateConversionError` if the conversion fails.
    func toString(format: String?) async throws -> String

    /// Creates an instance from a date string using the specified format.
    ///
    /// - Parameters:
    ///   - string: The string to convert from.
    ///   - format: The date format to use. If nil, uses ISO8601 format.
    /// - Returns: An instance of the conforming type.
    /// - Throws: `DateConversionError` if the conversion fails.
    static func fromString(_ string: String, format: String?) async throws -> Self
}

/// Errors specific to date conversion operations.
public enum DateConversionError: Error, LocalizedError, Equatable {
    /// The date string doesn't match the expected format.
    case invalidFormat(String)
    /// The date components are invalid (e.g., month > 12).
    case invalidComponents
    /// The provided format string is invalid.
    case invalidFormatString(String)
    /// A custom error with a specific message.
    case custom(String)

    public var errorDescription: String? {
        switch self {
            case .invalidFormat(let value):
                return "Date string doesn't match the expected format: \(value)"
            case .invalidComponents:
                return "Date contains invalid components"
            case .invalidFormatString(let format):
                return "Invalid date format string: \(format)"
            case .custom(let message):
                return message
        }
    }
}

/// Common date formats used in applications.
public enum DateFormat {
    /// ISO8601 format (e.g., "2025-01-16T15:30:00Z")
    public static let iso8601 = "yyyy-MM-dd'T'HH:mm:ssZ"
    /// HTTP format (e.g., "Wed, 16 Jan 2025 15:30:00 GMT")
    public static let http = "EEE, dd MMM yyyy HH:mm:ss zzz"
    /// Short date (e.g., "01/16/2025")
    public static let shortDate = "MM/dd/yyyy"
    /// Long date (e.g., "January 16, 2025")
    public static let longDate = "MMMM dd, yyyy"
    /// Time only (e.g., "15:30:00")
    public static let time = "HH:mm:ss"
    /// Date and time (e.g., "01/16/2025 15:30:00")
    public static let dateTime = "MM/dd/yyyy HH:mm:ss"
    /// Year and month (e.g., "January 2025")
    public static let yearMonth = "MMMM yyyy"
    /// Compact numeric (e.g., "20250116")
    public static let compact = "yyyyMMdd"
}
