// DateConversionTests.swift
// SwiftDevKit
//
// Copyright (c) 2025 owdax and The SwiftDevKit Contributors
// MIT License - https://opensource.org/licenses/MIT

import Foundation
import SwiftDevKit
import Testing

@Suite("Date Conversion Tests")
struct DateConversionTests {
    @Test("Test date string conversion with various formats")
    func testDateStringConversion() async throws {
        let date = Date(timeIntervalSince1970: 1705363800) // 2024-01-16 00:10:00 UTC

        // Test ISO8601
        let iso8601 = try await date.toISO8601()
        #expect(iso8601 == "2024-01-16T00:10:00+0000")
        let parsedISO = try await Date.fromISO8601(iso8601)
        #expect(parsedISO.timeIntervalSince1970 == date.timeIntervalSince1970)

        // Test HTTP date
        let httpDate = try await date.toHTTPDate()
        #expect(httpDate == "Tue, 16 Jan 2024 00:10:00 GMT")
        let parsedHTTP = try await Date.fromHTTPDate(httpDate)
        #expect(parsedHTTP.timeIntervalSince1970 == date.timeIntervalSince1970)

        // Test custom format
        let shortDate = try await date.toString(format: DateFormat.shortDate)
        #expect(shortDate == "01/16/2024")
        let parsedShort = try await Date.fromString(shortDate, format: DateFormat.shortDate)
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: parsedShort)
        #expect(components.year == 2024)
        #expect(components.month == 1)
        #expect(components.day == 16)
    }

    @Test("Test date conversion error handling")
    func testDateConversionErrors() async throws {
        // Test invalid format
        await #expect(throws: DateConversionError.invalidFormat("invalid")) {
            try await Date.fromString("invalid", format: DateFormat.iso8601)
        }

        // Test invalid format string
        await #expect(throws: Error.self) {
            try await Date.fromString("2024-01-16", format: "invalid")
        }
    }
}
