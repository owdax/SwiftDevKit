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
        roundingRule: NumberFormatter.RoundingMode?) throws -> String

    /// Formats the number as a percentage.
    ///
    /// - Parameters:
    ///   - decimals: Number of decimal places (default: 2)
    ///   - locale: The locale to use for formatting (default: current)
    /// - Returns: A formatted percentage string (e.g., "42.5%")
    /// - Throws: `NumberFormattingError` if formatting fails
    func asPercentage(
        decimals: Int?,
        locale: Locale?) throws -> String

    /// Formats the number as currency.
    ///
    /// - Parameters:
    ///   - code: The ISO 4217 currency code (e.g., "USD", "EUR")
    ///   - locale: The locale to use for formatting (default: current)
    /// - Returns: A formatted currency string (e.g., "$1,234.56")
    /// - Throws: `NumberFormattingError` if formatting fails
    func asCurrency(
        code: String,
        locale: Locale?) throws -> String

    /// Formats the number in scientific notation.
    ///
    /// - Parameters:
    ///   - decimals: Number of decimal places (default: 2)
    ///   - locale: The locale to use for formatting (default: current)
    /// - Returns: A scientific notation string (e.g., "1.23E4")
    /// - Throws: `NumberFormattingError` if formatting fails
    func asScientific(
        decimals: Int?,
        locale: Locale?) throws -> String

    /// Formats the number as an ordinal.
    ///
    /// - Parameters:
    ///   - locale: The locale to use for formatting (default: current)
    /// - Returns: An ordinal string (e.g., "1st", "2nd", "3rd", "4th")
    /// - Throws: `NumberFormattingError` if formatting fails
    func asOrdinal(
        locale: Locale?) throws -> String

    /// Spells out the number in words.
    ///
    /// - Parameters:
    ///   - locale: The locale to use for formatting (default: current)
    ///   - capitalized: Whether to capitalize the first word (default: false)
    /// - Returns: The number spelled out in words (e.g., "one thousand two hundred thirty-four")
    /// - Throws: `NumberFormattingError` if formatting fails
    func asWords(
        locale: Locale?,
        capitalized: Bool?) throws -> String

    /// Formats the number in compact style.
    ///
    /// - Parameters:
    ///   - style: The compact notation style (.short or .long) (default: .short)
    ///   - locale: The locale to use for formatting (default: current)
    /// - Returns: A compact string (e.g., "1.2K" or "1.2 thousand")
    /// - Throws: `NumberFormattingError` if formatting fails
    func asCompact(
        style: NumberFormatter.Style?,
        locale: Locale?) throws -> String

    /// Formats the number as a binary string.
    ///
    /// - Parameters:
    ///   - prefix: Whether to include "0b" prefix (default: false)
    ///   - grouping: Whether to group digits by 4 (default: false)
    /// - Returns: A binary string (e.g., "1010" or "0b1010" or "0b1010_1100")
    /// - Throws: `NumberFormattingError` if formatting fails
    func asBinary(
        prefix: Bool?,
        grouping: Bool?) throws -> String

    /// Formats the number as a hexadecimal string.
    ///
    /// - Parameters:
    ///   - prefix: Whether to include "0x" prefix (default: false)
    ///   - uppercase: Whether to use uppercase letters (default: false)
    /// - Returns: A hexadecimal string (e.g., "ff" or "0xFF")
    /// - Throws: `NumberFormattingError` if formatting fails
    func asHex(
        prefix: Bool?,
        uppercase: Bool?) throws -> String

    /// Formats the number as Roman numerals.
    ///
    /// - Parameter uppercase: Whether to use uppercase letters (default: true)
    /// - Returns: A Roman numeral string (e.g., "MCMLIV" or "mcmliv")
    /// - Throws: `NumberFormattingError` if formatting fails
    func asRoman(
        uppercase: Bool?) throws -> String

    /// Formats the number as an octal string.
    ///
    /// - Parameters:
    ///   - prefix: Whether to include "0o" prefix (default: false)
    ///   - grouping: Whether to group digits by 3 (default: false)
    /// - Returns: An octal string (e.g., "52" or "0o52" or "0o377")
    /// - Throws: `NumberFormattingError` if formatting fails
    func asOctal(
        prefix: Bool?,
        grouping: Bool?) throws -> String

    /// Formats the number in a custom base (radix).
    ///
    /// - Parameters:
    ///   - radix: The base to use (2-36)
    ///   - uppercase: Whether to use uppercase letters (default: false)
    /// - Returns: A string in the specified base
    /// - Throws: `NumberFormattingError` if formatting fails
    func asBase(
        _ radix: Int,
        uppercase: Bool?) throws -> String

    /// Formats the number in accounting style.
    ///
    /// - Parameters:
    ///   - code: The ISO 4217 currency code (e.g., "USD", "EUR")
    ///   - locale: The locale to use for formatting (default: current)
    ///   - showPositiveSymbol: Whether to show + symbol for positive numbers (default: false)
    /// - Returns: A formatted accounting string (e.g., "$1,234.56" or "($1,234.56)" for negative)
    /// - Throws: `NumberFormattingError` if formatting fails
    func asAccounting(
        code: String,
        locale: Locale?,
        showPositiveSymbol: Bool?) throws -> String

    /// Formats the number as a file size.
    ///
    /// - Parameters:
    ///   - style: The style to use (.file or .memory) (default: .file)
    ///   - includeUnit: Whether to include the unit (default: true)
    ///   - locale: The locale to use for formatting (default: current)
    /// - Returns: A formatted file size string (e.g., "1.5 MB" or "1.5 MiB")
    /// - Throws: `NumberFormattingError` if formatting fails
    func asFileSize(
        style: ByteCountFormatter.CountStyle?,
        includeUnit: Bool?,
        locale: Locale?) throws -> String

    /// Formats the number as a duration.
    ///
    /// - Parameters:
    ///   - style: The style to use (.abbreviated, .full, .short, .spellOut) (default: .abbreviated)
    ///   - locale: The locale to use for formatting (default: current)
    /// - Returns: A formatted duration string (e.g., "2h 30m" or "2 hours 30 minutes")
    /// - Throws: `NumberFormattingError` if formatting fails
    func asDuration(
        style: DateComponentsFormatter.UnitsStyle?,
        locale: Locale?) throws -> String

    /// Formats the number as a fraction.
    ///
    /// - Parameters:
    ///   - maxDenominator: Maximum denominator to use (default: 100)
    ///   - locale: The locale to use for formatting (default: current)
    /// - Returns: A formatted fraction string (e.g., "1 1/2" or "2/3")
    /// - Throws: `NumberFormattingError` if formatting fails
    func asFraction(
        maxDenominator: Int?,
        locale: Locale?) throws -> String

    /// Formats the number with a unit.
    ///
    /// - Parameters:
    ///   - unit: The unit to use (e.g., .meters, .kilograms)
    ///   - style: The formatting style (.short, .medium, .long) (default: .medium)
    ///   - locale: The locale to use for formatting (default: current)
    /// - Returns: A formatted unit string (e.g., "5.2 km" or "3.1 kg")
    /// - Throws: `NumberFormattingError` if formatting fails
    @available(macOS 12.0, iOS 15.0, watchOS 8.0, tvOS 15.0, *)
    func asUnit(
        _ unit: Dimension,
        style: Formatter.UnitStyle?,
        locale: Locale?) throws -> String
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
    func formatted() throws -> String {
        try formatted(decimals: 2, grouping: true, roundingRule: .halfUp)
    }

    func asPercentage(
        decimals: Int? = 2,
        locale: Locale? = .current) throws -> String
    {
        guard let number = self as? NSNumber else {
            throw NumberFormattingError.invalidNumber("Value cannot be converted to a number")
        }

        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.locale = locale ?? .current
        formatter.maximumFractionDigits = decimals ?? 2
        formatter.minimumFractionDigits = decimals ?? 2

        guard let result = formatter.string(from: number) else {
            throw NumberFormattingError.invalidNumber("Could not format as percentage")
        }
        return result
    }

    func asCurrency(
        code: String,
        locale: Locale? = .current) throws -> String
    {
        guard let number = self as? NSNumber else {
            throw NumberFormattingError.invalidNumber("Value cannot be converted to a number")
        }

        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = locale ?? .current
        formatter.currencyCode = code

        guard let result = formatter.string(from: number) else {
            throw NumberFormattingError.invalidNumber("Could not format as currency")
        }
        return result
    }

    func asScientific(
        decimals: Int? = 2,
        locale: Locale? = .current) throws -> String
    {
        guard let number = self as? NSNumber else {
            throw NumberFormattingError.invalidNumber("Value cannot be converted to a number")
        }

        let formatter = NumberFormatter()
        formatter.numberStyle = .scientific
        formatter.locale = locale ?? .current
        formatter.maximumFractionDigits = decimals ?? 2
        formatter.minimumFractionDigits = decimals ?? 2

        guard let result = formatter.string(from: number) else {
            throw NumberFormattingError.invalidNumber("Could not format as scientific notation")
        }
        return result
    }

    func asOrdinal(
        locale: Locale? = .current) throws -> String
    {
        guard let number = self as? NSNumber else {
            throw NumberFormattingError.invalidNumber("Value cannot be converted to a number")
        }

        let formatter = NumberFormatter()
        formatter.numberStyle = .ordinal
        formatter.locale = locale ?? .current

        guard let result = formatter.string(from: number) else {
            throw NumberFormattingError.invalidNumber("Could not format as ordinal")
        }
        return result
    }

    func asWords(
        locale: Locale? = .current,
        capitalized: Bool? = false) throws -> String
    {
        guard let number = self as? NSNumber else {
            throw NumberFormattingError.invalidNumber("Value cannot be converted to a number")
        }

        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        formatter.locale = locale ?? .current

        guard var result = formatter.string(from: number) else {
            throw NumberFormattingError.invalidNumber("Could not spell out number")
        }

        if capitalized ?? false {
            result = result.prefix(1).uppercased() + result.dropFirst()
        }
        return result
    }

    func asCompact(
        style: NumberFormatter.Style? = .decimal,
        locale: Locale? = .current) throws -> String
    {
        if #available(macOS 11.0, iOS 14.0, watchOS 7.0, tvOS 14.0, *) {
            guard let number = self as? NSNumber else {
                throw NumberFormattingError.invalidNumber("Value cannot be converted to a number")
            }

            let formatter = NumberFormatter()
            formatter.numberStyle = style ?? .decimal
            formatter.locale = locale ?? .current
            formatter.usesGroupingSeparator = true
            formatter.formattingContext = .standalone

            guard let result = formatter.string(from: number) else {
                throw NumberFormattingError.invalidNumber("Could not format in compact notation")
            }
            return result
        } else {
            throw NumberFormattingError.invalidOptions("Compact notation is only available on macOS 11.0+, iOS 14.0+")
        }
    }

    func asBinary(
        prefix: Bool? = false,
        grouping: Bool? = false) throws -> String
    {
        guard let number = self as? NSNumber else {
            throw NumberFormattingError.invalidNumber("Value cannot be converted to binary")
        }

        var binary = String(Int(truncating: number), radix: 2)

        if grouping ?? false {
            // Group digits by 4 from the right
            let padding = (4 - (binary.count % 4)) % 4
            binary = String(repeating: "0", count: padding) + binary

            var result = ""
            var index = 0
            for char in binary {
                if index > 0, index % 4 == 0 {
                    result += "_"
                }
                result += String(char)
                index += 1
            }
            binary = result.trimmingCharacters(in: CharacterSet(charactersIn: "_"))
        }

        return (prefix ?? false ? "0b" : "") + binary
    }

    func asHex(
        prefix: Bool? = false,
        uppercase: Bool? = false) throws -> String
    {
        guard let number = self as? NSNumber else {
            throw NumberFormattingError.invalidNumber("Value cannot be converted to hexadecimal")
        }

        var hex = String(Int(truncating: number), radix: 16)
        if uppercase ?? false {
            hex = hex.uppercased()
        }

        return (prefix ?? false ? "0x" : "") + hex
    }

    func asRoman(
        uppercase: Bool? = true) throws -> String
    {
        guard let number = self as? NSNumber,
              let intValue = Int(exactly: number),
              intValue > 0, intValue < 4000
        else {
            throw NumberFormattingError.invalidNumber("Value must be between 1 and 3999 for Roman numerals")
        }

        let romanValues: [(Int, String)] = [
            (1000, "M"), (900, "CM"), (500, "D"), (400, "CD"),
            (100, "C"), (90, "XC"), (50, "L"), (40, "XL"),
            (10, "X"), (9, "IX"), (5, "V"), (4, "IV"), (1, "I"),
        ]

        var result = ""
        var remaining = intValue

        for (value, symbol) in romanValues {
            while remaining >= value {
                result += symbol
                remaining -= value
            }
        }

        return (uppercase ?? true) ? result : result.lowercased()
    }

    func asOctal(
        prefix: Bool? = false,
        grouping: Bool? = false) throws -> String
    {
        guard let number = self as? NSNumber else {
            throw NumberFormattingError.invalidNumber("Value cannot be converted to octal")
        }

        var octal = String(Int(truncating: number), radix: 8)

        if grouping ?? false {
            // Group digits by 3 from the right
            let padding = (3 - (octal.count % 3)) % 3
            octal = String(repeating: "0", count: padding) + octal

            var result = ""
            var index = 0
            for char in octal {
                if index > 0, index % 3 == 0 {
                    result += "_"
                }
                result += String(char)
                index += 1
            }
            octal = result.trimmingCharacters(in: CharacterSet(charactersIn: "_"))
        }

        return (prefix ?? false ? "0o" : "") + octal
    }

    func asBase(
        _ radix: Int,
        uppercase: Bool? = false) throws -> String
    {
        guard let number = self as? NSNumber else {
            throw NumberFormattingError.invalidNumber("Value cannot be converted to base \(radix)")
        }

        guard radix >= 2, radix <= 36 else {
            throw NumberFormattingError.invalidOptions("Base must be between 2 and 36")
        }

        var result = String(Int(truncating: number), radix: radix)
        if uppercase ?? false {
            result = result.uppercased()
        }

        return result
    }

    func asAccounting(
        code: String,
        locale: Locale? = .current,
        showPositiveSymbol: Bool? = false) throws -> String
    {
        guard let number = self as? NSNumber else {
            throw NumberFormattingError.invalidNumber("Value cannot be converted to a number")
        }

        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = locale ?? .current
        formatter.currencyCode = code
        formatter.positivePrefix = (showPositiveSymbol ?? false) ? "+" : ""
        formatter.negativeFormat = "($#)"

        guard let result = formatter.string(from: number) else {
            throw NumberFormattingError.invalidNumber("Could not format as accounting notation")
        }
        return result
    }

    /// Formats the number as a file size.
    ///
    /// - Parameters:
    ///   - style: The style to use (.file or .memory) (default: .file)
    ///   - includeUnit: Whether to include the unit (default: true)
    ///   - locale: The locale to use for formatting (default: current)
    /// - Returns: A formatted file size string (e.g., "1.5 MB" or "1.5 MiB")
    /// - Throws: `NumberFormattingError` if formatting fails
    func asFileSize(
        style: ByteCountFormatter.CountStyle? = .file,
        includeUnit: Bool? = true,
        locale: Locale? = .current) throws -> String
    {
        guard let number = self as? NSNumber else {
            throw NumberFormattingError.invalidNumber("Value cannot be converted to a number")
        }

        let formatter = ByteCountFormatter()
        formatter.countStyle = style ?? .file
        formatter.includesUnit = includeUnit ?? true
        formatter.allowedUnits = [.useAll]
        formatter.isAdaptive = true

        return formatter.string(fromByteCount: Int64(truncating: number))
    }

    /// Formats the number as a duration.
    ///
    /// - Parameters:
    ///   - style: The style to use (.abbreviated, .full, .short, .spellOut) (default: .abbreviated)
    ///   - locale: The locale to use for formatting (default: current)
    /// - Returns: A formatted duration string (e.g., "2h 30m" or "2 hours 30 minutes")
    /// - Throws: `NumberFormattingError` if formatting fails
    func asDuration(
        style: DateComponentsFormatter.UnitsStyle? = .abbreviated,
        locale: Locale? = .current) throws -> String
    {
        guard let number = self as? NSNumber else {
            throw NumberFormattingError.invalidNumber("Value cannot be converted to a number")
        }

        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = style ?? .abbreviated
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.maximumUnitCount = 2
        formatter.calendar?.locale = locale ?? .current

        guard let result = formatter.string(from: TimeInterval(truncating: number)) else {
            throw NumberFormattingError.invalidNumber("Could not format as duration")
        }
        return result
    }

    /// Formats the number as a fraction.
    ///
    /// - Parameters:
    ///   - maxDenominator: Maximum denominator to use (default: 100)
    ///   - locale: The locale to use for formatting (default: current)
    /// - Returns: A formatted fraction string (e.g., "1 1/2" or "2/3")
    /// - Throws: `NumberFormattingError` if formatting fails
    func asFraction(
        maxDenominator: Int? = 100,
        locale: Locale? = .current) throws -> String
    {
        guard let number = self as? NSNumber,
              let doubleValue = Double(exactly: number)
        else {
            throw NumberFormattingError.invalidNumber("Value cannot be converted to a number")
        }

        let maxDen = maxDenominator ?? 100
        var num = Int(doubleValue)
        var frac = doubleValue - Double(num)

        if frac == 0 {
            return String(num)
        }

        var bestNum = 0
        var bestDen = 1
        var bestError = frac

        for den in 1...maxDen {
            let n = Int(round(frac * Double(den)))
            let error = abs(frac - Double(n) / Double(den))

            if error < bestError {
                bestNum = n
                bestDen = den
                bestError = error
            }
        }

        // Simplify the fraction
        let gcd = { (a: Int, b: Int) -> Int in
            var x = abs(a)
            var y = abs(b)
            while y != 0 {
                let temp = y
                y = x % y
                x = temp
            }
            return x
        }

        let divisor = gcd(bestNum, bestDen)
        bestNum /= divisor
        bestDen /= divisor

        if num != 0 {
            return "\(num) \(bestNum)/\(bestDen)"
        } else {
            return "\(bestNum)/\(bestDen)"
        }
    }

    /// Formats the number with a unit.
    ///
    /// - Parameters:
    ///   - unit: The unit to use (e.g., .meters, .kilograms)
    ///   - style: The formatting style (.short, .medium, .long) (default: .medium)
    ///   - locale: The locale to use for formatting (default: current)
    /// - Returns: A formatted unit string (e.g., "5.2 km" or "3.1 kg")
    /// - Throws: `NumberFormattingError` if formatting fails
    @available(macOS 12.0, iOS 15.0, watchOS 8.0, tvOS 15.0, *)
    func asUnit(
        _ unit: Dimension,
        style: Formatter.UnitStyle? = .medium,
        locale: Locale? = .current) throws -> String
    {
        guard let number = self as? NSNumber else {
            throw NumberFormattingError.invalidNumber("Value cannot be converted to a number")
        }

        let measurement = Measurement(value: Double(truncating: number), unit: unit)
        let formatter = MeasurementFormatter()
        formatter.unitStyle = style ?? .medium
        formatter.locale = locale ?? .current

        return formatter.string(from: measurement)
    }
}
