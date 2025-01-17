// NumberFormattingTests.swift
// SwiftDevKit
//
// Copyright (c) 2025 owdax and The SwiftDevKit Contributors
// MIT License - https://opensource.org/licenses/MIT

import Foundation
import SwiftDevKit
import Testing

@Suite("Number Formatting Tests")
struct NumberFormattingTests {
    @Test("Test basic integer formatting")
    func testIntegerFormatting() async throws {
        let number = 1_234_567

        // Default formatting
        let defaultFormatted = try await number.formatted()
        #expect(defaultFormatted == "1,234,567")

        // Without grouping
        let noGrouping = try await number.formatted(decimals: 0, grouping: false)
        #expect(noGrouping == "1234567")

        // Negative numbers
        let negative = -1_234_567
        let negativeFormatted = try await negative.formatted()
        #expect(negativeFormatted == "-1,234,567")
    }

    @Test("Test decimal number formatting")
    func testDecimalFormatting() async throws {
        let number = 1234.5678

        // Default formatting (2 decimals)
        let defaultFormatted = try await number.formatted()
        #expect(defaultFormatted == "1,234.57")

        // Custom decimals
        let fourDecimals = try await number.formatted(decimals: 4)
        #expect(fourDecimals == "1,234.5678")

        // No decimals
        let noDecimals = try await number.formatted(decimals: 0)
        #expect(noDecimals == "1,235")

        // Without grouping
        let noGrouping = try await number.formatted(decimals: 2, grouping: false)
        #expect(noGrouping == "1234.57")
    }

    @Test("Test float formatting")
    func testFloatFormatting() async throws {
        let number: Float = 1234.5678

        // Default formatting (2 decimals)
        let defaultFormatted = try await number.formatted()
        #expect(defaultFormatted == "1,234.57")

        // Custom decimals
        let threeDecimals = try await number.formatted(decimals: 3)
        #expect(threeDecimals == "1,234.568")

        // No grouping
        let noGrouping = try await number.formatted(grouping: false)
        #expect(noGrouping == "1234.57")
    }

    @Test("Test rounding rules")
    func testRoundingRules() async throws {
        let number = 1234.5678

        // Round down
        let roundDown = try await number.formatted(decimals: 2, roundingRule: .down)
        #expect(roundDown == "1,234.56")

        // Round up
        let roundUp = try await number.formatted(decimals: 2, roundingRule: .up)
        #expect(roundUp == "1,234.57")

        // Round to nearest
        let roundNearest = try await number.formatted(decimals: 2, roundingRule: .halfUp)
        #expect(roundNearest == "1,234.57")
    }
}
