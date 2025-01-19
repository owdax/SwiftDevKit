// StringTransformable.swift
// SwiftDevKit
//
// Copyright (c) 2025 owdax and The SwiftDevKit Contributors
// MIT License - https://opensource.org/licenses/MIT

import Foundation

/// A type that can perform various string transformations.
///
/// This protocol provides a standardized way to transform strings with common operations
/// like case conversion, whitespace handling, and pattern-based transformations.
///
/// Example usage:
/// ```swift
/// let text = "hello world"
/// try text.toTitleCase()      // "Hello World"
/// try text.toCamelCase()      // "helloWorld"
/// try text.toSnakeCase()      // "hello_world"
/// try text.toKebabCase()      // "hello-world"
/// ```
public protocol StringTransformable {
    /// Converts the string to title case.
    ///
    /// - Returns: A string with the first letter of each word capitalized.
    /// - Throws: `StringTransformError` if the transformation fails.
    func toTitleCase() throws -> String
    
    /// Converts the string to camel case.
    ///
    /// - Returns: A string in camelCase format.
    /// - Throws: `StringTransformError` if the transformation fails.
    func toCamelCase() throws -> String
    
    /// Converts the string to snake case.
    ///
    /// - Returns: A string in snake_case format.
    /// - Throws: `StringTransformError` if the transformation fails.
    func toSnakeCase() throws -> String
    
    /// Converts the string to kebab case.
    ///
    /// - Returns: A string in kebab-case format.
    /// - Throws: `StringTransformError` if the transformation fails.
    func toKebabCase() throws -> String
    
    /// Removes excess whitespace from the string.
    ///
    /// - Returns: A string with normalized whitespace.
    /// - Throws: `StringTransformError` if the transformation fails.
    func removeExcessWhitespace() throws -> String
    
    /// Truncates the string to the specified length.
    ///
    /// - Parameters:
    ///   - length: The maximum length of the resulting string.
    ///   - smart: Whether to preserve word boundaries.
    ///   - ellipsis: The string to append when truncating (default: "...").
    /// - Returns: A truncated string.
    /// - Throws: `StringTransformError` if the transformation fails.
    func truncate(length: Int, smart: Bool?, ellipsis: String?) throws -> String
}

/// Errors that can occur during string transformations.
public enum StringTransformError: Error, LocalizedError, Equatable {
    /// The input string is invalid for the requested transformation.
    case invalidInput(String)
    /// The transformation operation failed.
    case transformationFailed(String)
    /// A custom error with a specific message.
    case custom(String)
    
    public var errorDescription: String? {
        switch self {
        case let .invalidInput(value):
            "Invalid input string: \(value)"
        case let .transformationFailed(message):
            "Transformation failed: \(message)"
        case let .custom(message):
            message
        }
    }
} 