// String+Metrics.swift
// SwiftDevKit
//
// Copyright (c) 2025 owdax and The SwiftDevKit Contributors
// MIT License - https://opensource.org/licenses/MIT

import Foundation

public extension String {
    /// Calculates the Levenshtein distance between this string and another string.
    ///
    /// The Levenshtein distance is the minimum number of single-character edits (insertions, deletions, or
    /// substitutions)
    /// required to change one string into another.
    ///
    /// Example:
    /// ```swift
    /// let distance = "kitten".levenshteinDistance(to: "sitting")  // Returns 3
    /// ```
    ///
    /// - Parameter other: The string to compare against
    /// - Returns: The Levenshtein distance between the two strings
    func levenshteinDistance(to other: String) -> Int {
        let str1 = Array(self)
        let str2 = Array(other)
        let str1Length = str1.count
        let str2Length = str2.count

        // Handle empty strings
        if str1Length == 0 { return str2Length }
        if str2Length == 0 { return str1Length }

        // Create matrix of size (str1Length+1)x(str2Length+1)
        var matrix = Array(repeating: Array(repeating: 0, count: str2Length + 1), count: str1Length + 1)

        // Initialize first row and column
        for i in 0...str1Length {
            matrix[i][0] = i
        }
        for j in 0...str2Length {
            matrix[0][j] = j
        }

        // Fill in the rest of the matrix
        for i in 1...str1Length {
            for j in 1...str2Length {
                if str1[i - 1] == str2[j - 1] {
                    matrix[i][j] = matrix[i - 1][j - 1] // No operation needed
                } else {
                    matrix[i][j] = Swift.min(
                        matrix[i - 1][j] + 1, // deletion
                        matrix[i][j - 1] + 1, // insertion
                        matrix[i - 1][j - 1] + 1 // substitution
                    )
                }
            }
        }

        return matrix[str1Length][str2Length]
    }

    /// Calculates the Jaro-Winkler distance between this string and another string.
    ///
    /// The Jaro-Winkler distance is a measure of similarity between two strings, with a higher score
    /// indicating greater similarity (1.0 means the strings are identical, 0.0 means completely different).
    /// It's particularly suited for short strings like names.
    ///
    /// Example:
    /// ```swift
    /// let similarity = "martha".jaroWinklerDistance(to: "marhta")  // Returns ~0.961
    /// ```
    ///
    /// - Parameters:
    ///   - other: The string to compare against
    ///   - scalingFactor: The scaling factor for how much the prefix affects the score (default: 0.1)
    /// - Returns: A value between 0.0 and 1.0, where 1.0 means the strings are identical
    func jaroWinklerDistance(to other: String, scalingFactor: Double = 0.1) -> Double {
        let str1 = Array(self)
        let str2 = Array(other)
        let len1 = str1.count
        let len2 = str2.count

        // If either string is empty, return 0
        if len1 == 0 || len2 == 0 {
            return 0.0
        }

        // Maximum distance between two characters to be considered matching
        let matchDistance = (Swift.max(len1, len2) / 2) - 1

        // Arrays to keep track of matched characters
        var matches1 = [Bool](repeating: false, count: len1)
        var matches2 = [Bool](repeating: false, count: len2)

        // Count matching characters
        var matchingChars = 0
        for i in 0..<len1 {
            // Calculate window start and end
            let start = Swift.max(0, i - matchDistance)
            let end = Swift.min(len2, i + matchDistance + 1)

            // Skip if start would be greater than end
            guard start <= end else { continue }

            for j in start..<end where !matches2[j] && str1[i] == str2[j] {
                matches1[i] = true
                matches2[j] = true
                matchingChars += 1
                break
            }
        }

        // If no characters match, return 0
        guard matchingChars > 0 else {
            return 0.0
        }

        // Count transpositions
        var transpositions = 0
        var j = 0
        for i in 0..<len1 where matches1[i] {
            while j < len2, !matches2[j] {
                j += 1
            }
            if j < len2, str1[i] != str2[j] {
                transpositions += 1
            }
            j += 1
        }

        // Calculate Jaro distance
        let matchCount = Double(matchingChars)
        let transpositionCount = Double(transpositions) / 2.0
        let jaro =
            (
                (matchCount / Double(len1)) + (matchCount / Double(len2)) +
                    ((matchCount - transpositionCount) / matchCount)) / 3.0

        // Calculate common prefix length (up to 4 characters)
        var commonPrefix = 0
        let maxPrefix = Swift.min(Swift.min(len1, len2), 4)
        for i in 0..<maxPrefix where str1[i] == str2[i] {
            commonPrefix += 1
        }

        // Calculate Jaro-Winkler distance
        return jaro + (Double(commonPrefix) * scalingFactor * (1.0 - jaro))
    }

    /// Calculates the Hamming distance between this string and another string.
    ///
    /// The Hamming distance is the number of positions at which the corresponding symbols
    /// in two strings of equal length are different.
    ///
    /// Example:
    /// ```swift
    /// let distance = "karolin".hammingDistance(to: "kathrin")  // Returns 3
    /// ```
    ///
    /// - Parameter other: The string to compare against
    /// - Returns: The Hamming distance between the two strings
    /// - Throws: `StringMetricsError.unequalLength` if the strings have different lengths
    func hammingDistance(to other: String) throws -> Int {
        guard count == other.count else {
            throw StringMetricsError.unequalLength(
                "Hamming distance requires strings of equal length: \(count) != \(other.count)")
        }

        var distance = 0
        for i in 0..<count {
            let char1 = self[index(startIndex, offsetBy: i)]
            let char2 = other[other.index(other.startIndex, offsetBy: i)]
            if char1 != char2 {
                distance += 1
            }
        }

        return distance
    }
}

/// A collection of metrics describing a string's content.
public struct StringMetrics {
    /// The total length of the string
    public let totalLength: Int

    /// The number of words in the string
    public let wordCount: Int

    /// The number of characters in the string
    public let characterCount: Int

    /// The number of letters in the string
    public let letterCount: Int

    /// The number of digits in the string
    public let digitCount: Int

    /// The number of whitespace characters in the string
    public let whitespaceCount: Int

    /// The number of punctuation characters in the string
    public let punctuationCount: Int

    /// The number of symbol characters in the string
    public let symbolCount: Int

    /// The number of lines in the string
    public let lineCount: Int
}

/// Errors that can occur during string metrics calculations.
public enum StringMetricsError: Error, LocalizedError {
    /// Thrown when an operation requires strings of equal length but received strings of different lengths.
    case unequalLength(String)

    public var errorDescription: String? {
        switch self {
            case let .unequalLength(message):
                message
        }
    }
}
