// StringExtractionTests.swift
// SwiftDevKit
//
// Copyright (c) 2025 owdax and The SwiftDevKit Contributors
// MIT License - https://opensource.org/licenses/MIT

import Foundation
import Testing
@testable import SwiftDevKit

@Suite("String Extraction Tests")
struct StringExtractionTests {
    @Test("Test number extraction")
    func testNumberExtraction() throws {
        let text = "The price is $19.99 and quantity is -42"

        // With negative numbers
        let numbers = text.extractNumbers()
        #expect(numbers.count == 2)
        #expect(numbers.contains("19.99"))
        #expect(numbers.contains("-42"))

        // Without negative numbers
        let positiveOnly = text.extractNumbers(includeNegative: false)
        #expect(positiveOnly.count == 1)
        #expect(positiveOnly.contains("19.99"))
    }

    @Test("Test word extraction")
    func testWordExtraction() throws {
        let text = "Hello, World! How are you?"

        // Default minimum length
        let words = text.extractWords()
        #expect(words.count == 5)
        #expect(words == ["Hello", "World", "How", "are", "you"])

        // Custom minimum length
        let longWords = text.extractWords(minLength: 4)
        #expect(longWords.count == 2)
        #expect(longWords == ["Hello", "World"])
    }

    @Test("Test sentence extraction")
    func testSentenceExtraction() throws {
        let text = "Hello! How are you? I'm doing great."

        let sentences = text.extractSentences()
        #expect(sentences.count == 3)
        #expect(sentences == ["Hello", "How are you", "I'm doing great"])

        // Empty string
        #expect("".extractSentences().isEmpty)

        // Single sentence
        #expect("Just one sentence.".extractSentences() == ["Just one sentence"])
    }

    @Test("Test URL extraction")
    func testURLExtraction() throws {
        let text = "Visit https://www.example.com or http://test.com or ftp://files.com"

        // Default schemes (http, https)
        let urls = text.extractURLs()
        #expect(urls.count == 2)
        #expect(urls.contains("https://www.example.com"))
        #expect(urls.contains("http://test.com"))

        // Custom schemes
        let allUrls = text.extractURLs(schemes: ["http", "https", "ftp"])
        #expect(allUrls.count == 3)
        #expect(allUrls.contains("ftp://files.com"))
    }

    @Test("Test email extraction")
    func testEmailExtraction() throws {
        let text = "Contact us at info@example.com or support@test.com"

        let emails = text.extractEmails()
        #expect(emails.count == 2)
        #expect(emails.contains("info@example.com"))
        #expect(emails.contains("support@test.com"))

        // Invalid emails
        let invalidText = "Invalid emails: @invalid.com and user@.com"
        #expect(invalidText.extractEmails().isEmpty)
    }

    @Test("Test hashtag extraction")
    func testHashtagExtraction() throws {
        let text = "Check out #SwiftDev and #iOS15 features!"

        // With hash symbol
        let hashtags = text.extractHashtags()
        #expect(hashtags.count == 2)
        #expect(hashtags.contains("#SwiftDev"))
        #expect(hashtags.contains("#iOS15"))

        // Without hash symbol
        let tags = text.extractHashtags(includeHash: false)
        #expect(tags.count == 2)
        #expect(tags.contains("SwiftDev"))
        #expect(tags.contains("iOS15"))
    }

    @Test("Test mention extraction")
    func testMentionExtraction() throws {
        let text = "Thanks @john and @jane_doe!"

        // With @ symbol
        let mentions = text.extractMentions()
        #expect(mentions.count == 2)
        #expect(mentions.contains("@john"))
        #expect(mentions.contains("@jane_doe"))

        // Without @ symbol
        let usernames = text.extractMentions(includeAt: false)
        #expect(usernames.count == 2)
        #expect(usernames.contains("john"))
        #expect(usernames.contains("jane_doe"))
    }

    @Test("Test date extraction")
    func testDateExtraction() throws {
        let text = """
        Meeting on 2024-01-16
        Party on 01/20/2024
        Event on 25.12.2024
        Conference on January 30, 2024
        """

        let dates = text.extractDates()
        #expect(dates.count == 4)
        #expect(dates.contains("2024-01-16"))
        #expect(dates.contains("01/20/2024"))
        #expect(dates.contains("25.12.2024"))
        #expect(dates.contains("January 30, 2024"))

        // Invalid dates
        let invalidText = "Invalid dates: 2024-13-45 and 00/00/0000"
        let invalidDates = invalidText.extractDates()
        #expect(invalidDates.isEmpty)
    }
}
