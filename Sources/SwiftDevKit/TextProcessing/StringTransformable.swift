// StringTransformable.swift
// SwiftDevKit
//
// Copyright (c) 2025 owdax and The SwiftDevKit Contributors
// MIT License - https://opensource.org/licenses/MIT

import Foundation

/// Errors that can occur during string transformations.
public enum StringTransformError: LocalizedError, Equatable {
    /// Thrown when a string transformation operation fails.
    case transformationFailed(String)

    /// Thrown when strings have unequal length for operations requiring equal lengths.
    case unequalLength(String)

    public var errorDescription: String? {
        switch self {
            case let .transformationFailed(message):
                "String transformation failed: \(message)"
            case let .unequalLength(message):
                "String length mismatch: \(message)"
        }
    }
}

/// A protocol defining string transformation operations.
public protocol StringTransformable {
    /// Converts the string to title case.
    ///
    /// Example:
    /// ```swift
    /// "hello world".toTitleCase()  // Returns "Hello World"
    /// ```
    ///
    /// - Returns: The string in title case
    /// - Throws: `StringTransformError.transformationFailed` if the transformation fails
    func toTitleCase() throws -> String

    /// Converts the string to camel case.
    ///
    /// Example:
    /// ```swift
    /// "hello world".toCamelCase()  // Returns "helloWorld"
    /// ```
    ///
    /// - Returns: The string in camel case
    /// - Throws: `StringTransformError.transformationFailed` if the transformation fails
    func toCamelCase() throws -> String

    /// Converts the string to snake case.
    ///
    /// Example:
    /// ```swift
    /// "hello world".toSnakeCase()  // Returns "hello_world"
    /// ```
    ///
    /// - Returns: The string in snake case
    /// - Throws: `StringTransformError.transformationFailed` if the transformation fails
    func toSnakeCase() throws -> String

    /// Converts the string to kebab case.
    ///
    /// Example:
    /// ```swift
    /// "hello world".toKebabCase()  // Returns "hello-world"
    /// ```
    ///
    /// - Returns: The string in kebab case
    /// - Throws: `StringTransformError.transformationFailed` if the transformation fails
    func toKebabCase() throws -> String

    /// Removes excess whitespace from the string.
    ///
    /// Example:
    /// ```swift
    /// "  hello   world  ".removeExcessWhitespace()  // Returns "hello world"
    /// ```
    ///
    /// - Returns: The string with excess whitespace removed
    /// - Throws: `StringTransformError.transformationFailed` if the transformation fails
    func removeExcessWhitespace() throws -> String

    /// Truncates the string to a specified length.
    ///
    /// Example:
    /// ```swift
    /// "Hello, World!".truncate(length: 5, ellipsis: "...")  // Returns "Hello..."
    /// ```
    ///
    /// - Parameters:
    ///   - length: The maximum length of the truncated string (including ellipsis)
    ///   - ellipsis: The string to append to truncated text
    /// - Returns: The truncated string
    /// - Throws: `StringTransformError.transformationFailed` if the transformation fails
    func truncate(length: Int, ellipsis: String) throws -> String
}
