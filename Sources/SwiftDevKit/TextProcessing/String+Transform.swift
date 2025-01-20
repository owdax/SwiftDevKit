// String+Transform.swift
// SwiftDevKit
//
// Copyright (c) 2025 owdax and The SwiftDevKit Contributors
// MIT License - https://opensource.org/licenses/MIT

import Foundation

extension String: StringTransformable {
    public func toTitleCase() throws -> String {
        let words = split(separator: " ")
        guard !words.isEmpty else {
            return self
        }

        return words
            .map { $0.prefix(1).uppercased() + $0.dropFirst().lowercased() }
            .joined(separator: " ")
    }

    public func toCamelCase() throws -> String {
        let words = split { !$0.isLetter && !$0.isNumber }
            .enumerated()
            .map { index, word -> String in
                let lowercased = word.lowercased()
                return index == 0 ? lowercased : lowercased.prefix(1).uppercased() + lowercased.dropFirst()
            }

        guard !words.isEmpty else {
            return self
        }

        return words.joined()
    }

    public func toSnakeCase() throws -> String {
        // Handle empty strings and whitespace-only strings
        guard !trimmingCharacters(in: .whitespaces).isEmpty else {
            return self
        }

        // First, handle special characters and spaces
        let normalized = replacingOccurrences(of: "[-._]", with: " ", options: .regularExpression)
            .replacingOccurrences(of: "\\s+", with: " ", options: .regularExpression)
            .trimmingCharacters(in: .whitespaces)

        // Special case for acronyms
        if normalized.allSatisfy(\.isUppercase) {
            return normalized.lowercased().map { String($0) }.joined(separator: "_")
        }

        var result = ""
        var lastCharWasLower = false
        var isFirstChar = true

        for (index, char) in normalized.enumerated() {
            if char.isUppercase {
                let nextCharIsLower = index + 1 < normalized.count &&
                    normalized[normalized.index(normalized.startIndex, offsetBy: index + 1)].isLowercase

                if !isFirstChar, lastCharWasLower || nextCharIsLower {
                    result += "_"
                }

                result += String(char).lowercased()
                lastCharWasLower = false
            } else if char.isLowercase {
                result += String(char)
                lastCharWasLower = true
            } else if char.isWhitespace {
                result += "_"
                lastCharWasLower = false
            }
            isFirstChar = false
        }

        // Clean up any double underscores and trim
        return result
            .replacingOccurrences(of: "_+", with: "_", options: .regularExpression)
            .trimmingCharacters(in: CharacterSet(charactersIn: "_"))
    }

    public func toKebabCase() throws -> String {
        // Handle empty strings and whitespace-only strings
        guard !trimmingCharacters(in: .whitespaces).isEmpty else {
            return self
        }

        // Convert to snake case first, then replace underscores with hyphens
        return try toSnakeCase().replacingOccurrences(of: "_", with: "-")
    }

    public func removeExcessWhitespace() throws -> String {
        let components = components(separatedBy: .whitespacesAndNewlines)
        return components
            .filter { !$0.isEmpty }
            .joined(separator: " ")
    }

    /// Truncates the string to a specified length.
    ///
    /// Example:
    /// ```swift
    /// "Hello, World!".truncate(length: 5, ellipsis: "...")  // Returns "Hello..."
    /// ```
    ///
    /// - Parameters:
    ///   - length: The maximum length of the truncated string (including ellipsis)
    ///   - ellipsis: The string to append to truncated text
    /// - Returns: The truncated string
    /// - Throws: `StringTransformError.transformationFailed` if the transformation fails
    public func truncate(length: Int, ellipsis: String) throws -> String {
        // Validate input length
        guard length > 0 else {
            throw StringTransformError.transformationFailed("Length must be greater than 0")
        }

        // If the string is already shorter than the target length, return it as is
        if count <= length {
            return self
        }

        // Calculate where to truncate, accounting for ellipsis length
        let truncateAt = length - ellipsis.count
        guard truncateAt > 0 else {
            // If ellipsis is too long, just return ellipsis truncated to length
            return String(ellipsis.prefix(length))
        }

        // Simple truncation at exact character position
        return String(prefix(truncateAt)) + ellipsis
    }
}
