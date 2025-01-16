// DateConversionTests.swift
// SwiftDevKit
//
// Copyright (c) 2025 owdax and The SwiftDevKit Contributors
// MIT License - https://opensource.org/licenses/MIT

import _TestingInternals
import Foundation
import SwiftDevKit
import Testing

/// Test suite for date conversion functionality.
/// Following the Arrange-Act-Assert pattern and including both positive and negative test cases.
struct DateConversionTests {
    /// Tests basic date string conversion with various formats
    func testDateStringConversion() async throws {
        // Create a fixed test date (January 16, 2025, 15:30:45 GMT)
        let calendar = Calendar(identifier: .gregorian)
        let components = DateComponents(
            year: 2025,
            month: 1,
            day: 16,
            hour: 15,
            minute: 30,
            second: 45,
            nanosecond: 0)
        guard let testDate = calendar.date(from: components) else {
            throw DateConversionError.custom("Failed to create test date")
        }

        // MARK: - ISO8601 Format

        let iso8601String = try await testDate.toISO8601()
        #expect(iso8601String == "2025-01-16T15:30:45Z")

        let parsedISO8601Date = try await Date.fromISO8601(iso8601String)
        #expect(calendar.isDate(parsedISO8601Date, equalTo: testDate, toGranularity: .second))

        // MARK: - HTTP Format

        let httpString = try await testDate.toHTTPDate()
        #expect(httpString == "Thu, 16 Jan 2025 15:30:45 GMT")

        let parsedHTTPDate = try await Date.fromHTTPDate(httpString)
        #expect(calendar.isDate(parsedHTTPDate, equalTo: testDate, toGranularity: .second))

        // MARK: - Custom Formats

        // Test each format with proper thread safety
        async let shortDate = testDate.toString(format: DateFormat.shortDate)
        async let longDate = testDate.toString(format: DateFormat.longDate)
        async let timeOnly = testDate.toString(format: DateFormat.time)
        async let dateTime = testDate.toString(format: DateFormat.dateTime)
        async let yearMonth = testDate.toString(format: DateFormat.yearMonth)
        async let compact = testDate.toString(format: DateFormat.compact)

        // Wait for all concurrent format operations
        try await #expect(shortDate == "01/16/2025")
        try await #expect(longDate == "January 16, 2025")
        try await #expect(timeOnly == "15:30:45")
        try await #expect(dateTime == "01/16/2025 15:30:45")
        try await #expect(yearMonth == "January 2025")
        try await #expect(compact == "20250116")
    }

    /// Tests error handling in date conversion
    func testDateConversionErrors() async throws {
        // Test invalid ISO8601 string
        await #expect(throws: DateConversionError.invalidFormat("invalid")) {
            try await Date.fromISO8601("invalid")
        }

        // Test invalid HTTP date string
        await #expect(throws: DateConversionError.invalidFormat("invalid")) {
            try await Date.fromHTTPDate("invalid")
        }

        // Test invalid format string
        await #expect(throws: DateConversionError.invalidFormat("2025-13-45")) {
            try await Date.fromString("2025-13-45", format: DateFormat.shortDate)
        }

        // Test empty string
        await #expect(throws: DateConversionError.invalidFormat("")) {
            try await Date.fromString("", format: DateFormat.shortDate)
        }

        // Test malformed date string
        await #expect(throws: DateConversionError.invalidFormat("01/16")) {
            try await Date.fromString("01/16", format: DateFormat.shortDate)
        }
    }

    /// Tests thread safety of date formatter cache
    func testDateFormatterThreadSafety() async throws {
        // Create a large number of concurrent date parsing operations
        async let operations = withThrowingTaskGroup(of: Date.self) { group in
            for index in 0..<100 {
                group.addTask {
                    let dateString = "2025-01-\(String(format: "%02d", (index % 28) + 1))T12:00:00Z"
                    return try await Date.fromISO8601(dateString)
                }
            }

            // Collect results to ensure all operations complete
            var dates: [Date] = []
            for try await date in group {
                dates.append(date)
            }
            return dates
        }

        // Verify we got all dates
        let results = try await operations
        #expect(results.count == 100, "All concurrent operations should complete successfully")
    }
}
