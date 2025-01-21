// TimeUtilitiesTests.swift
// SwiftDevKit
//
// Copyright (c) 2025 owdax and The SwiftDevKit Contributors
// MIT License - https://opensource.org/licenses/MIT

import Foundation
import Testing
@testable import SwiftDevKit

struct TestError: Error {
    let message: String
    
    init(_ message: String) {
        self.message = message
    }
}

@Suite("Time Utilities Tests")
struct TimeUtilitiesTests {
    @Test("Test relative time formatting")
    func testRelativeTime() throws {
        let now = Date()
        
        // Past times
        let twoHoursAgo = now.addingTimeInterval(-7200)
        let threeDaysAgo = now.addingTimeInterval(-259200)
        guard let oneYearAgo = Calendar.current.date(byAdding: .year, value: -1, to: now) else {
            throw TestError("Failed to create date one year ago")
        }
        
        // Future times
        let inOneHour = now.addingTimeInterval(3600)
        let inTwoDays = now.addingTimeInterval(172800)
        
        // Test different styles
        let shortStyle = TimeUtilities.relativeTime(from: twoHoursAgo, style: TimeUtilities.RelativeTimeStyle.short)
        #expect(shortStyle.contains("2h"))
        
        let mediumStyle = TimeUtilities.relativeTime(from: threeDaysAgo, style: TimeUtilities.RelativeTimeStyle.medium)
        #expect(mediumStyle.contains("3 days"))
        
        let longStyle = TimeUtilities.relativeTime(from: oneYearAgo, style: TimeUtilities.RelativeTimeStyle.long)
        #expect(longStyle.contains("1 year"))
        
        // Test future dates
        let futureShort = TimeUtilities.relativeTime(from: inOneHour, style: TimeUtilities.RelativeTimeStyle.short)
        #expect(futureShort.contains("in 1h"))
        
        let futureMedium = TimeUtilities.relativeTime(from: inTwoDays, style: TimeUtilities.RelativeTimeStyle.medium)
        #expect(futureMedium.contains("in 2 days"))
        
        // Test "just now"
        let justNow = TimeUtilities.relativeTime(from: now, style: TimeUtilities.RelativeTimeStyle.medium)
        #expect(justNow == "just now")
    }
    
    @Test("Test duration formatting")
    func testDurationFormatting() throws {
        // Test different durations
        let shortDuration = TimeUtilities.formatDuration(seconds: 45, style: TimeUtilities.RelativeTimeStyle.short)
        #expect(shortDuration.contains("45s") || shortDuration.contains("45 sec"))
        
        let mediumDuration = TimeUtilities.formatDuration(seconds: 3665) // 1 hour, 1 minute, 5 seconds
        #expect(mediumDuration.contains("hour"))
        
        let longDuration = TimeUtilities.formatDuration(seconds: 7384, style: TimeUtilities.RelativeTimeStyle.long) // 2 hours, 3 minutes
        #expect(longDuration.contains("hours") && longDuration.contains("minutes"))
        
        let preciseDuration = TimeUtilities.formatDuration(seconds: 7384, style: TimeUtilities.RelativeTimeStyle.precise)
        #expect(preciseDuration.contains("hours") && preciseDuration.contains("minutes") && preciseDuration.contains("seconds"))
    }
    
    @Test("Test time remaining calculation")
    func testTimeRemaining() throws {
        let now = Date()
        
        // Test future date
        let futureDate = now.addingTimeInterval(7200) // 2 hours in future
        let remaining = TimeUtilities.timeRemaining(until: futureDate)
        #expect(remaining?.contains("2 hours") == true)
        
        // Test past date
        let pastDate = now.addingTimeInterval(-3600) // 1 hour in past
        let pastRemaining = TimeUtilities.timeRemaining(until: pastDate)
        #expect(pastRemaining == nil)
        
        // Test different styles
        let shortRemaining = TimeUtilities.timeRemaining(until: futureDate, style: TimeUtilities.RelativeTimeStyle.short)
        #expect(shortRemaining?.contains("2h") == true)
        
        let longRemaining = TimeUtilities.timeRemaining(until: futureDate, style: TimeUtilities.RelativeTimeStyle.long)
        #expect(longRemaining?.contains("2 hours") == true)
    }
    
    @Test("Test isWithin function")
    func testIsWithin() throws {
        let now = Date()
        
        // Test within range
        let oneHourAgo = now.addingTimeInterval(-3600)
        #expect(TimeUtilities.isWithin(date: oneHourAgo, unit: TimeUtilities.TimeUnit.hours, value: 2))
        
        // Test outside range
        let threeDaysAgo = now.addingTimeInterval(-259200)
        #expect(!TimeUtilities.isWithin(date: threeDaysAgo, unit: TimeUtilities.TimeUnit.days, value: 2))
        
        // Test edge cases
        let exactlyTwoHoursAgo = now.addingTimeInterval(-7200)
        #expect(TimeUtilities.isWithin(date: exactlyTwoHoursAgo, unit: TimeUtilities.TimeUnit.hours, value: 2))
        
        // Test different units
        let tenMinutesAgo = now.addingTimeInterval(-600)
        #expect(TimeUtilities.isWithin(date: tenMinutesAgo, unit: TimeUtilities.TimeUnit.minutes, value: 15))
        #expect(!TimeUtilities.isWithin(date: tenMinutesAgo, unit: TimeUtilities.TimeUnit.minutes, value: 5))
    }
} 