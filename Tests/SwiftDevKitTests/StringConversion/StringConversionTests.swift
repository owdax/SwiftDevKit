// StringConversionTests.swift
// SwiftDevKit
//
// Copyright (c) 2025 owdax and The SwiftDevKit Contributors
// MIT License - https://opensource.org/licenses/MIT

import _TestingInternals
import Foundation
import SwiftDevKit
import Testing

/// Test suite for string conversion functionality.
/// Following the Arrange-Act-Assert pattern and including both positive and negative test cases.
struct StringConversionTests {
    /// Tests string conversion for various numeric types.
    func testNumericStringConversion() throws {
        // MARK: - Integer Tests

        // Test valid integer conversion
        let intValue = try Int.fromString("42")
        #expect(intValue == 42)
        #expect(try intValue.toString() == "42")

        // Test invalid integer input
        #expect(throws: StringConversionError.invalidInput("invalid")) {
            try Int.fromString("invalid")
        }

        // MARK: - Double Tests

        // Test valid double conversion
        let doubleValue = try Double.fromString("3.14")
        #expect(doubleValue == 3.14)
        #expect(try doubleValue.toString() == "3.14")

        // Test invalid double input
        #expect(throws: StringConversionError.invalidInput("invalid")) {
            try Double.fromString("invalid")
        }

        // MARK: - Float Tests

        // Test valid float conversion
        let floatValue = try Float.fromString("1.23")
        #expect(floatValue == 1.23)
        #expect(try floatValue.toString() == "1.23")

        // Test invalid float input
        #expect(throws: StringConversionError.invalidInput("invalid")) {
            try Float.fromString("invalid")
        }

        // MARK: - Edge Cases

        // Test maximum values
        let maxInt = try Int.fromString(String(Int.max))
        #expect(maxInt == Int.max)

        // Test minimum values
        let minInt = try Int.fromString(String(Int.min))
        #expect(minInt == Int.min)

        // Test zero
        let zero = try Int.fromString("0")
        #expect(zero == 0)

        // Test negative numbers
        let negative = try Int.fromString("-42")
        #expect(negative == -42)
    }

    /// Tests error handling in string conversion.
    func testStringConversionErrors() throws {
        // Test empty string
        #expect(throws: StringConversionError.invalidInput("")) {
            try Int.fromString("")
        }

        // Test whitespace
        #expect(throws: StringConversionError.invalidInput(" ")) {
            try Int.fromString(" ")
        }

        // Test non-numeric characters
        #expect(throws: StringConversionError.invalidInput("12.34.56")) {
            try Int.fromString("12.34.56")
        }

        // Test overflow scenarios
        let overflowString = "999999999999999999999999999999"
        #expect(throws: StringConversionError.invalidInput(overflowString)) {
            try Int.fromString(overflowString)
        }
    }
}
