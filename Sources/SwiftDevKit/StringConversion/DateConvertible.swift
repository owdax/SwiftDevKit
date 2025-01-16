// DateConvertible.swift
// SwiftDevKit
//
// Copyright (c) 2025 owdax and The SwiftDevKit Contributors
// MIT License - https://opensource.org/licenses/MIT

import Foundation

/// A type that can be converted to and from date string representations with thread-safe operations.
///
/// This protocol provides date-specific conversion capabilities that are safe for concurrent access.
/// It uses an actor-based formatter cache to ensure thread safety when working with `DateFormatter` instances.
///
/// Example usage:
/// ```swift
/// let date = Date()
/// // Convert to ISO8601
/// let isoString = try await date.toISO8601()
/// // Convert using custom format
/// let customString = try await date.toString(format: DateFormat.shortDate)
/// ```
public protocol DateConvertible {
    /// Converts the instance to a date string using the specified format.
    ///
    /// This method is thread-safe and can be called concurrently from multiple tasks.
    /// The date formatter cache ensures optimal performance while maintaining thread safety.
    ///
    /// - Parameter format: The date format to use. If nil, uses ISO8601 format.
    /// - Returns: A string representation of the date.
    /// - Throws: `DateConversionError` if the conversion fails.
    func toString(format: String?) async throws -> String

    /// Creates an instance from a date string using the specified format.
    ///
    /// This method is thread-safe and can be called concurrently from multiple tasks.
    /// The date formatter cache ensures optimal performance while maintaining thread safety.
    ///
    /// - Parameters:
    ///   - string: The string to convert from.
    ///   - format: The date format to use. If nil, uses ISO8601 format.
    /// - Returns: An instance of the conforming type.
    /// - Throws: `DateConversionError` if the string is not in the expected format.
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
        case let .invalidFormat(value):
            return "Date string doesn't match the expected format: \(value)"
        case .invalidComponents:
            return "Date contains invalid components"
        case let .invalidFormatString(format):
            return "Invalid date format string: \(format)"
        case let .custom(message):
            return message
        }
    }
}

/// Common date formats used in applications.
///
/// This enum provides a set of predefined date format strings that cover common use cases.
/// All formats use the POSIX locale and UTC timezone for consistency across platforms.
public enum DateFormat {
    /// ISO8601 format (e.g., "2025-01-16T15:30:00Z")
    /// Commonly used for API communication and data interchange.
    public static let iso8601 = "yyyy-MM-dd'T'HH:mm:ssZ"
    
    /// HTTP format (e.g., "Wed, 16 Jan 2025 15:30:00 GMT")
    /// Used in HTTP headers like "If-Modified-Since" and "Last-Modified".
    public static let http = "EEE, dd MMM yyyy HH:mm:ss zzz"
    
    /// Short date (e.g., "01/16/2025")
    /// Compact representation for display purposes.
    public static let shortDate = "MM/dd/yyyy"
    
    /// Long date (e.g., "January 16, 2025")
    /// Human-readable format with full month name.
    public static let longDate = "MMMM dd, yyyy"
    
    /// Time only (e.g., "15:30:00")
    /// For when only the time component is needed.
    public static let time = "HH:mm:ss"
    
    /// Date and time (e.g., "01/16/2025 15:30:00")
    /// Combined date and time for complete timestamp display.
    public static let dateTime = "MM/dd/yyyy HH:mm:ss"
    
    /// Year and month (e.g., "January 2025")
    /// For month-level granularity display.
    public static let yearMonth = "MMMM yyyy"
    
    /// Compact numeric (e.g., "20250116")
    /// For file names or when space is at a premium.
    public static let compact = "yyyyMMdd"
}
