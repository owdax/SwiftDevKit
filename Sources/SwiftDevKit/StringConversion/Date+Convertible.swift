// Date+Convertible.swift
// SwiftDevKit
//
// Copyright (c) 2025 owdax and The SwiftDevKit Contributors
// MIT License - https://opensource.org/licenses/MIT

import Foundation

/// Actor that manages thread-safe access to date formatters
private actor DateFormatterCache {
    /// Cache of date formatters
    private var formatters: [String: DateFormatter] = [:]
    
    /// Gets or creates a date formatter for the specified format
    func formatter(for format: String) -> DateFormatter {
        if let formatter = formatters[format] {
            return formatter
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatters[format] = formatter
        return formatter
    }
}

extension Date: DateConvertible {
    /// Thread-safe date formatter cache
    private static let formatterCache = DateFormatterCache()
    
    public func toString(format: String?) async throws -> String {
        let dateFormat = format ?? DateFormat.iso8601
        let formatter = await Self.formatterCache.formatter(for: dateFormat)
        return formatter.string(from: self)
    }
    
    public static func fromString(_ string: String, format: String?) async throws -> Date {
        let dateFormat = format ?? DateFormat.iso8601
        let formatter = await formatterCache.formatter(for: dateFormat)
        
        guard let date = formatter.date(from: string) else {
            throw DateConversionError.invalidFormat(string)
        }
        
        return date
    }
}

// MARK: - Convenience Methods

public extension Date {
    /// Creates a date from an ISO8601 string
    ///
    /// - Parameter iso8601String: The ISO8601 formatted string
    /// - Returns: A new Date instance
    /// - Throws: DateConversionError if the string is not valid ISO8601
    static func fromISO8601(_ iso8601String: String) async throws -> Date {
        try await fromString(iso8601String, format: DateFormat.iso8601)
    }
    
    /// Converts the date to an ISO8601 string
    ///
    /// - Returns: An ISO8601 formatted string
    /// - Throws: DateConversionError if the conversion fails
    func toISO8601() async throws -> String {
        try await toString(format: DateFormat.iso8601)
    }
    
    /// Creates a date from an HTTP date string
    ///
    /// - Parameter httpDateString: The HTTP date formatted string
    /// - Returns: A new Date instance
    /// - Throws: DateConversionError if the string is not a valid HTTP date
    static func fromHTTPDate(_ httpDateString: String) async throws -> Date {
        try await fromString(httpDateString, format: DateFormat.http)
    }
    
    /// Converts the date to an HTTP date string
    ///
    /// - Returns: An HTTP date formatted string
    /// - Throws: DateConversionError if the conversion fails
    func toHTTPDate() async throws -> String {
        try await toString(format: DateFormat.http)
    }
}
