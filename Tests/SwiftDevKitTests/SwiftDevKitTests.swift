// SwiftDevKitTests.swift
// SwiftDevKit
//
// Copyright (c) 2025 owdax and The SwiftDevKit Contributors
// MIT License - https://opensource.org/licenses/MIT

import Foundation
import SwiftDevKit
import Testing

// MARK: - Core Tests

@Test
func versionTest() async throws {
    #expect(SwiftDevKit.version == "1.0.0", "Version should match the current release")
}

@Test
func environmentValidationTest() async throws {
    #expect(SwiftDevKit.isEnvironmentValid, "Environment should be valid on supported platforms")
}

// MARK: - Platform Support Tests

@Test
func platformSupportTest() async throws {
    #if os(iOS)
        #expect(SwiftDevKit.isEnvironmentValid, "Should support iOS")
    #elseif os(macOS)
        #expect(SwiftDevKit.isEnvironmentValid, "Should support macOS")
    #elseif os(tvOS)
        #expect(SwiftDevKit.isEnvironmentValid, "Should support tvOS")
    #elseif os(watchOS)
        #expect(SwiftDevKit.isEnvironmentValid, "Should support watchOS")
    #endif
}
