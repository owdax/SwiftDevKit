// TruncateDebug.swift
// SwiftDevKit
//
// Copyright (c) 2025 owdax and The SwiftDevKit Contributors
// MIT License - https://opensource.org/licenses/MIT

import Foundation
import Testing
@testable import SwiftDevKit

@Suite("Truncate Debug Tests")
struct TruncateDebugTests {
    @Test("Debug truncation")
    func debugTruncation() throws {
        let text = "This is a long text that needs to be truncated"
        print("\nInput text: '\(text)'")
        print("Input length: \(text.count)")

        // Test case 1: length: 20, smart: false
        print("\n=== Test case 1: length: 20, smart: false ===")
        let truncateAt1 = 20 - "...".count
        print("Truncate at: \(truncateAt1)")

        let endIndex1 = text.index(text.startIndex, offsetBy: truncateAt1)
        let truncated1 = String(text[..<endIndex1])
        print("Raw truncated: '\(truncated1)'")

        let lastSpaceIndex1 = truncated1.lastIndex(of: " ") ?? truncated1.startIndex
        print("Last space position: \(truncated1.distance(from: truncated1.startIndex, to: lastSpaceIndex1))")

        let lastWord1 = truncated1[lastSpaceIndex1...].trimmingCharacters(in: .whitespaces)
        print("Last word: '\(lastWord1)'")
        print("Last word length: \(lastWord1.count)")

        let result1 = try text.truncate(length: 20, smart: false)
        print("\nResult 1:")
        print("Expected: 'This is a long t...'")
        print("Actual  : '\(result1)'")
        print("Length  : \(result1.count)")

        // Test case 2: length: 10, ellipsis: "…"
        print("\n=== Test case 2: length: 10, ellipsis: '…', smart: false ===")
        let truncateAt2 = 10 - "…".count
        print("Truncate at: \(truncateAt2)")

        let endIndex2 = text.index(text.startIndex, offsetBy: truncateAt2)
        let truncated2 = String(text[..<endIndex2])
        print("Raw truncated: '\(truncated2)'")

        let lastSpaceIndex2 = truncated2.lastIndex(of: " ") ?? truncated2.startIndex
        print("Last space position: \(truncated2.distance(from: truncated2.startIndex, to: lastSpaceIndex2))")

        let lastWord2 = truncated2[lastSpaceIndex2...].trimmingCharacters(in: .whitespaces)
        print("Last word: '\(lastWord2)'")
        print("Last word length: \(lastWord2.count)")

        let result2 = try text.truncate(length: 10, smart: false, ellipsis: "…")
        print("\nResult 2:")
        print("Expected: 'This is…'")
        print("Actual  : '\(result2)'")
        print("Length  : \(result2.count)")
    }
}
