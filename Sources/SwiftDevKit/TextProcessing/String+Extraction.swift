// String+Extraction.swift
// SwiftDevKit
//
// Copyright (c) 2025 owdax and The SwiftDevKit Contributors
// MIT License - https://opensource.org/licenses/MIT

import Foundation

public extension String {
    /// Extracts all numbers from the string.
    ///
    /// Example:
    /// ```swift
    /// let text = "The price is $19.99 and quantity is 42"
    /// let numbers = text.extractNumbers()  // ["19.99", "42"]
    /// ```
    ///
    /// - Parameter includeNegative: Whether to include negative numbers (default: true)
    /// - Returns: An array of strings containing the extracted numbers
    func extractNumbers(includeNegative: Bool = true) -> [String] {
        let pattern = includeNegative ?
            #"-?\d+\.?\d*"# : // Match numbers with optional negative sign
            #"(?<![0-9.-])\d+\.?\d*"# // Match numbers not preceded by digits, dots, or minus
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return [] }

        let range = NSRange(startIndex..., in: self)
        return regex.matches(in: self, range: range)
            .compactMap { match in
                guard let range = Range(match.range, in: self) else { return nil }
                return String(self[range])
            }
    }

    /// Extracts all words from the string.
    ///
    /// Example:
    /// ```swift
    /// let text = "Hello, World! How are you?"
    /// let words = text.extractWords()  // ["Hello", "World", "How", "are", "you"]
    /// ```
    ///
    /// - Parameter minLength: Minimum length for a word to be included (default: 1)
    /// - Returns: An array of strings containing the extracted words
    func extractWords(minLength: Int = 1) -> [String] {
        components(separatedBy: .punctuationCharacters)
            .joined()
            .components(separatedBy: .whitespaces)
            .filter { $0.count >= minLength && !$0.isEmpty }
    }

    /// Extracts all sentences from the string.
    ///
    /// Example:
    /// ```swift
    /// let text = "Hello! How are you? I'm doing great."
    /// let sentences = text.extractSentences()  // ["Hello!", "How are you?", "I'm doing great."]
    /// ```
    ///
    /// - Returns: An array of strings containing the extracted sentences
    func extractSentences() -> [String] {
        components(separatedBy: CharacterSet(charactersIn: ".!?"))
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
    }

    /// Extracts all URLs from the string.
    ///
    /// Example:
    /// ```swift
    /// let text = "Visit https://www.example.com or http://test.com"
    /// let urls = text.extractURLs()  // ["https://www.example.com", "http://test.com"]
    /// ```
    ///
    /// - Parameter schemes: Array of URL schemes to match (default: ["http", "https"])
    /// - Returns: An array of strings containing the extracted URLs
    func extractURLs(schemes: [String] = ["http", "https"]) -> [String] {
        let pattern = schemes
            .map { #"\b\#($0)://[^\s<>\"]+[\w]"# }
            .joined(separator: "|")
        
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return [] }
        
        let range = NSRange(startIndex..., in: self)
        return regex.matches(in: self, range: range)
            .compactMap { match in
                guard let range = Range(match.range, in: self) else { return nil }
                return String(self[range])
            }
    }

    /// Extracts all email addresses from the string.
    ///
    /// Example:
    /// ```swift
    /// let text = "Contact us at info@example.com or support@test.com"
    /// let emails = text.extractEmails()  // ["info@example.com", "support@test.com"]
    /// ```
    ///
    /// - Returns: An array of strings containing the extracted email addresses
    func extractEmails() -> [String] {
        let pattern = #"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}"#
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return [] }
        
        let range = NSRange(startIndex..., in: self)
        return regex.matches(in: self, range: range)
            .compactMap { match in
                guard let range = Range(match.range, in: self) else { return nil }
                return String(self[range])
            }
    }

    /// Extracts all hashtags from the string.
    ///
    /// Example:
    /// ```swift
    /// let text = "Check out #SwiftDev and #iOS15 features!"
    /// let hashtags = text.extractHashtags()  // ["#SwiftDev", "#iOS15"]
    /// ```
    ///
    /// - Parameter includeHash: Whether to include the # symbol (default: true)
    /// - Returns: An array of strings containing the extracted hashtags
    func extractHashtags(includeHash: Bool = true) -> [String] {
        let pattern = #"#[a-zA-Z][a-zA-Z0-9_]*"#
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return [] }
        
        let range = NSRange(startIndex..., in: self)
        let matches = regex.matches(in: self, range: range)
            .compactMap { match in
                guard let range = Range(match.range, in: self) else { return nil }
                return String(self[range])
            }
        return matches.map { (str: String) -> String in includeHash ? str : String(str.dropFirst()) }
    }

    /// Extracts all mentions (@username) from the string.
    ///
    /// Example:
    /// ```swift
    /// let text = "Thanks @john and @jane_doe!"
    /// let mentions = text.extractMentions()  // ["@john", "@jane_doe"]
    /// ```
    ///
    /// - Parameter includeAt: Whether to include the @ symbol (default: true)
    /// - Returns: An array of strings containing the extracted mentions
    func extractMentions(includeAt: Bool = true) -> [String] {
        let pattern = #"@[a-zA-Z][a-zA-Z0-9_]*"#
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return [] }
        
        let range = NSRange(startIndex..., in: self)
        let matches = regex.matches(in: self, range: range)
            .compactMap { match in
                guard let range = Range(match.range, in: self) else { return nil }
                return String(self[range])
            }
        return matches.map { (str: String) -> String in includeAt ? str : String(str.dropFirst()) }
    }

    /// Extracts all dates from the string.
    ///
    /// Example:
    /// ```swift
    /// let text = "Meeting on 2024-01-16 and party on 01/20/2024"
    /// let dates = text.extractDates()  // ["2024-01-16", "01/20/2024"]
    /// ```
    ///
    /// - Returns: An array of strings containing the extracted valid dates
    func extractDates() -> [String] {
        let patterns = [
            #"\d{4}-\d{2}-\d{2}"#,              // YYYY-MM-DD
            #"\d{2}/\d{2}/\d{4}"#,              // MM/DD/YYYY
            #"\d{2}\.\d{2}\.\d{4}"#,            // DD.MM.YYYY
            #"[A-Za-z]+ \d{1,2}, \d{4}"#        // Month DD, YYYY
        ]
        
        let combinedPattern = patterns.joined(separator: "|")
        guard let regex = try? NSRegularExpression(pattern: combinedPattern) else { return [] }
        
        let range = NSRange(startIndex..., in: self)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "UTC")

        return regex.matches(in: self, range: range)
            .compactMap { match in
                guard let range = Range(match.range, in: self) else { return nil }
                return String(self[range])
            }
            .filter { dateString in
                // Try different date formats
                let formats = [
                    "yyyy-MM-dd",    // YYYY-MM-DD
                    "MM/dd/yyyy",    // MM/DD/YYYY
                    "dd.MM.yyyy",    // DD.MM.YYYY
                    "MMMM d, yyyy"   // Month DD, YYYY
                ]
                
                return formats.contains { format in
                    dateFormatter.dateFormat = format
                    return dateFormatter.date(from: dateString) != nil
                }
            }
    }
}
