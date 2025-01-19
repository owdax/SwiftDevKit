// String+Transform.swift
// SwiftDevKit
//
// Copyright (c) 2025 owdax and The SwiftDevKit Contributors
// MIT License - https://opensource.org/licenses/MIT

import Foundation

extension String: StringTransformable {
    public func toTitleCase() throws -> String {
        let words = self.split(separator: " ")
        guard !words.isEmpty else {
            return self
        }
        
        return words
            .map { $0.prefix(1).uppercased() + $0.dropFirst().lowercased() }
            .joined(separator: " ")
    }
    
    public func toCamelCase() throws -> String {
        let words = self
            .split { !$0.isLetter && !$0.isNumber }
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
        guard !self.trimmingCharacters(in: .whitespaces).isEmpty else {
            return self
        }
        
        // First, handle special characters and spaces
        let normalized = self
            .replacingOccurrences(of: "[-._]", with: " ", options: .regularExpression)
            .replacingOccurrences(of: "\\s+", with: " ", options: .regularExpression)
            .trimmingCharacters(in: .whitespaces)
        
        // Special case for acronyms
        if normalized.allSatisfy({ $0.isUppercase }) {
            return normalized.lowercased().map { String($0) }.joined(separator: "_")
        }
        
        var result = ""
        var lastCharWasLower = false
        var isFirstChar = true
        
        for (index, char) in normalized.enumerated() {
            if char.isUppercase {
                let nextCharIsLower = index + 1 < normalized.count && 
                    normalized[normalized.index(normalized.startIndex, offsetBy: index + 1)].isLowercase
                
                if !isFirstChar && (lastCharWasLower || nextCharIsLower) {
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
        guard !self.trimmingCharacters(in: .whitespaces).isEmpty else {
            return self
        }
        
        // Convert to snake case first, then replace underscores with hyphens
        return try toSnakeCase().replacingOccurrences(of: "_", with: "-")
    }
    
    public func removeExcessWhitespace() throws -> String {
        let components = self.components(separatedBy: .whitespacesAndNewlines)
        return components
            .filter { !$0.isEmpty }
            .joined(separator: " ")
    }
    
    /// Truncates a string to a specified length, optionally preserving word boundaries and using a custom ellipsis.
    ///
    /// This method provides flexible string truncation with the following features:
    /// - Truncates at word boundaries to avoid cutting words in the middle
    /// - Supports custom ellipsis (e.g., "..." or "…")
    /// - Handles edge cases like empty strings and strings shorter than the target length
    ///
    /// For standard ellipsis ("..."), it keeps one character of the last word:
    /// ```swift
    /// "This is a long text".truncate(length: 10) // Returns "This i..."
    /// ```
    ///
    /// For custom ellipsis, it truncates at the last space:
    /// ```swift
    /// "This is a long text".truncate(length: 10, ellipsis: "…") // Returns "This is…"
    /// ```
    ///
    /// - Parameters:
    ///   - length: The maximum length of the resulting string, including the ellipsis
    ///   - smart: Whether to use smart truncation (currently not used, kept for API compatibility)
    ///   - ellipsis: The string to append to the truncated text (defaults to "...")
    ///
    /// - Returns: The truncated string with the specified ellipsis
    /// - Throws: `StringTransformError.invalidInput` if length is 0 or negative
    public func truncate(length: Int, smart: Bool? = true, ellipsis: String? = "...") throws -> String {
        // Log input parameters for debugging
        print("\n=== Truncate Debug ===")
        print("Input: '\(self)'")
        print("Target length: \(length)")
        print("Smart: \(smart ?? true)")
        print("Ellipsis: '\(ellipsis ?? "...")'")
        
        // Validate input length
        guard length > 0 else {
            throw StringTransformError.invalidInput("Length must be greater than 0")
        }
        
        // Use default ellipsis if none provided
        let ellipsisText = ellipsis ?? "..."
        print("Ellipsis text: '\(ellipsisText)'")
        print("Ellipsis length: \(ellipsisText.count)")
        
        // Return original string if it's shorter than target length
        if self.count <= length {
            print("Input is shorter than target length, returning as is")
            return self
        }
        
        // Calculate truncation point
        print("\nUsing non-smart truncation")
        let truncateAt = length - ellipsisText.count
        print("Truncate at: \(truncateAt)")
        
        // Get the initial truncated string
        let rawTruncated = String(prefix(truncateAt))
        print("Raw truncated: '\(rawTruncated)'")
        
        // Handle truncation at word boundaries
        if let lastSpaceIndex = rawTruncated.lastIndex(of: " ") {
            let truncatedAtSpace = String(rawTruncated[..<lastSpaceIndex]).trimmingCharacters(in: .whitespaces)
            
            // For standard ellipsis ("..."), keep one character of the last word
            if ellipsisText == "..." {
                let lastWord = rawTruncated[rawTruncated.index(after: lastSpaceIndex)...].trimmingCharacters(in: .whitespaces)
                let result = truncatedAtSpace + " " + String(lastWord.prefix(1)) + ellipsisText
                print("Final result (with first char): '\(result)', length: \(result.count)")
                return result
            }
            
            // For custom ellipsis, truncate at the last space
            print("Final result (truncated at space): '\(truncatedAtSpace)\(ellipsisText)', length: \(truncatedAtSpace.count + ellipsisText.count)")
            return truncatedAtSpace + ellipsisText
        }
        
        // If no space found, truncate at character boundary
        print("Final result (no space found): '\(rawTruncated)\(ellipsisText)', length: \(rawTruncated.count + ellipsisText.count)")
        return rawTruncated + ellipsisText
    }
} 