// NumericStringConvertible.swift
// SwiftDevKit
//
// Copyright (c) 2025 owdax and The SwiftDevKit Contributors
// MIT License - https://opensource.org/licenses/MIT

import Foundation

/// Extends numeric types to provide string conversion capabilities.
/// This extension follows the Single Responsibility Principle by focusing solely on numeric string conversion.
public extension StringConvertible where Self: Numeric & LosslessStringConvertible {
    func toString() throws -> String {
        String(describing: self)
    }

    static func fromString(_ string: String) throws -> Self {
        guard let value = Self(string) else {
            throw StringConversionError.invalidInput(string)
        }
        return value
    }
}

// Conformance for basic numeric types
extension Int: StringConvertible {}
extension Double: StringConvertible {}
extension Float: StringConvertible {}
extension Int64: StringConvertible {}
extension UInt: StringConvertible {}
extension UInt64: StringConvertible {}
