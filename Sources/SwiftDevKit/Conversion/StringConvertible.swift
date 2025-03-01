// StringConvertible.swift
// SwiftDevKit
//
// Copyright (c) 2025 owdax and The SwiftDevKit Contributors
// MIT License - https://opensource.org/licenses/MIT

import Foundation

/// A type that can be converted to and from a string representation.
///
/// This protocol provides a standardized way to convert types to and from their string representations.
/// It follows the Interface Segregation Principle by keeping the interface focused and minimal.
public protocol StringConvertible {
    /// Converts the instance to its string representation.
    ///
    /// - Returns: A string representation of the instance.
    /// - Throws: `StringConversionError` if the conversion fails.
    func toString() throws -> String

    /// Creates an instance from its string representation.
    ///
    /// - Parameter string: The string to convert from.
    /// - Returns: An instance of the conforming type.
    /// - Throws: `StringConversionError` if the conversion fails.
    static func fromString(_ string: String) throws -> Self
}

/// Errors that can occur during string conversion operations.
public enum StringConversionError: Error, LocalizedError, Equatable {
    /// The input string is invalid for the requested conversion.
    case invalidInput(String)
    /// The conversion operation is not supported for this type.
    case unsupportedConversion
    /// A custom error with a specific message.
    case custom(String)

    public var errorDescription: String? {
        switch self {
            case let .invalidInput(value):
                "Invalid input string: \(value)"
            case .unsupportedConversion:
                "Unsupported conversion operation"
            case let .custom(message):
                message
        }
    }
}
