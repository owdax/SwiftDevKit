// SwiftDevKit.swift
// SwiftDevKit
//
// Copyright (c) 2025 owdax and The SwiftDevKit Contributors
// MIT License - https://opensource.org/licenses/MIT

/// SwiftDevKit
///
/// A comprehensive Swift SDK providing a rich collection of developer tools and utilities.
/// This framework is designed to be your go-to toolkit for common development tasks.
///
/// ## Overview
/// SwiftDevKit provides a wide range of functionalities organized into different categories:
/// - Data Conversion
/// - Cryptography
/// - Text Processing
/// - Development Helpers
/// - Platform Utilities
///
/// ## Usage
/// Import the framework:
/// ```swift
/// import SwiftDevKit
/// ```
///
/// ## Version
/// - Version: 1.0.0
/// - Swift: 5.9
///
public enum SwiftDevKit {
    /// The current version of SwiftDevKit
    public static let version = "1.0.0"

    /// Validates if the current environment meets the minimum requirements
    public static var isEnvironmentValid: Bool {
        #if os(iOS)
        return true
        #elseif os(macOS)
        return true
        #elseif os(tvOS)
        return true
        #elseif os(watchOS)
        return true
        #else
        return false
        #endif
    }
}

// MARK: - Feature Categories

/// Namespace for data conversion utilities
public enum DataConversion {}

/// Namespace for cryptography utilities
public enum Cryptography {}

/// Namespace for text processing utilities
public enum TextProcessing {}

/// Namespace for development helper utilities
public enum DevHelpers {}

/// Namespace for platform-specific utilities
public enum PlatformUtils {}
