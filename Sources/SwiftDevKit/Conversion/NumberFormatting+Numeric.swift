// NumberFormatting+Numeric.swift
// SwiftDevKit
//
// Copyright (c) 2025 owdax and The SwiftDevKit Contributors
// MIT License - https://opensource.org/licenses/MIT

import Foundation

// MARK: - Numeric Types Conformance

extension Int: NumberFormattable {
    public func formatted(
        decimals: Int? = nil,
        grouping: Bool? = nil,
        roundingRule: NumberFormatter.RoundingMode? = nil) throws -> String
    {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = decimals ?? 0
        formatter.usesGroupingSeparator = grouping ?? true
        formatter.roundingMode = roundingRule ?? .down

        guard let result = formatter.string(from: NSNumber(value: self)) else {
            throw NumberFormattingError.invalidNumber(String(self))
        }
        return result
    }
}

extension Double: NumberFormattable {
    public func formatted(
        decimals: Int? = nil,
        grouping: Bool? = nil,
        roundingRule: NumberFormatter.RoundingMode? = nil) throws -> String
    {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = decimals ?? 2
        formatter.minimumFractionDigits = decimals ?? 2
        formatter.usesGroupingSeparator = grouping ?? true
        formatter.roundingMode = roundingRule ?? .down

        guard let result = formatter.string(from: NSNumber(value: self)) else {
            throw NumberFormattingError.invalidNumber(String(self))
        }
        return result
    }
}

extension Float: NumberFormattable {
    public func formatted(
        decimals: Int? = nil,
        grouping: Bool? = nil,
        roundingRule: NumberFormatter.RoundingMode? = nil) throws -> String
    {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = decimals ?? 2
        formatter.minimumFractionDigits = decimals ?? 2
        formatter.usesGroupingSeparator = grouping ?? true
        formatter.roundingMode = roundingRule ?? .down

        guard let result = formatter.string(from: NSNumber(value: self)) else {
            throw NumberFormattingError.invalidNumber(String(self))
        }
        return result
    }
}
