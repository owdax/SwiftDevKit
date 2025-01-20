// String+Metrics.swift
// SwiftDevKit
//
// Copyright (c) 2025 owdax and The SwiftDevKit Contributors
// MIT License - https://opensource.org/licenses/MIT

import Foundation

/// A collection of metrics describing a string's content.
public struct StringMetrics {
    /// The total length of the string
    public let totalLength: Int

    /// The number of words in the string
    public let wordCount: Int

    /// The number of characters in the string
    public let characterCount: Int

    /// The number of letters in the string
    public let letterCount: Int

    /// The number of digits in the string
    public let digitCount: Int

    /// The number of whitespace characters in the string
    public let whitespaceCount: Int

    /// The number of punctuation characters in the string
    public let punctuationCount: Int

    /// The number of symbol characters in the string
    public let symbolCount: Int

    /// The number of lines in the string
    public let lineCount: Int
}

/// Errors that can occur during string metrics calculations.
public enum StringMetricsError: Error, LocalizedError {
    /// Thrown when an operation requires strings of equal length but received strings of different lengths.
    case unequalLength(String)

    public var errorDescription: String? {
        switch self {
            case let .unequalLength(message):
                message
        }
    }
}
