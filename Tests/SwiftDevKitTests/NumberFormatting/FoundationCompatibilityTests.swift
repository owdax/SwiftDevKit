// FoundationCompatibilityTests.swift
// SwiftDevKit
//
// Copyright (c) 2025 owdax and The SwiftDevKit Contributors
// MIT License - https://opensource.org/licenses/MIT

import Foundation
import SwiftDevKit
import Testing

/// Importing SwiftDevKit must not shadow Foundation APIs in client code.
/// A regression here shows up as a compile error, not a failed expectation.
@Suite("Foundation Compatibility Tests")
struct FoundationCompatibilityTests {
    @Test("Foundation's formatted() stays non-throwing")
    func testFoundationFormattedIsNotShadowed() {
        let int: String = 1_234_567.formatted()
        let double: String = 1234.5678.formatted()

        #expect(int == 1_234_567.formatted(.number))
        #expect(double == 1234.5678.formatted(.number))
    }
}
