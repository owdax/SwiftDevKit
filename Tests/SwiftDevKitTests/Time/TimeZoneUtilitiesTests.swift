// TimeZoneUtilitiesTests.swift
// SwiftDevKit
//
// Copyright (c) 2025 owdax and The SwiftDevKit Contributors
// MIT License - https://opensource.org/licenses/MIT

import Foundation
import Testing
@testable import SwiftDevKit

@Suite("Time Zone Utilities Tests")
struct TimeZoneUtilitiesTests {
    @Test("Test time zone conversion")
    func testTimeZoneConversion() throws {
        let date = Date(timeIntervalSince1970: 1705881600) // Jan 22, 2024 00:00:00 UTC
        guard let utc = TimeZone(identifier: "UTC"),
              let ny = TimeZone(identifier: "America/New_York"),
              let tokyo = TimeZone(identifier: "Asia/Tokyo") else {
            throw TestError("Failed to create time zones")
        }
        
        // Test UTC to NY conversion
        let nyTime = TimeZoneUtilities.convert(date: date, from: utc, to: ny)
        let nyOffset = ny.secondsFromGMT(for: date)
        #expect(nyTime.timeIntervalSince1970 == date.timeIntervalSince1970 + Double(nyOffset - utc.secondsFromGMT(for: date)))
        
        // Test UTC to Tokyo conversion
        let tokyoTime = TimeZoneUtilities.convert(date: date, from: utc, to: tokyo)
        let tokyoOffset = tokyo.secondsFromGMT(for: date)
        #expect(tokyoTime.timeIntervalSince1970 == date.timeIntervalSince1970 + Double(tokyoOffset - utc.secondsFromGMT(for: date)))
        
        // Test conversion during DST transition
        let dstDate = Date(timeIntervalSince1970: 1710061200) // March 10, 2024 07:00:00 UTC (DST start in US)
        let beforeDST = TimeZoneUtilities.convert(date: dstDate, from: utc, to: ny)
        let afterDST = TimeZoneUtilities.convert(date: dstDate.addingTimeInterval(7200), from: utc, to: ny)
        #expect(afterDST.timeIntervalSince1970 - beforeDST.timeIntervalSince1970 == 7200)
    }
    
    @Test("Test date formatting with time zones")
    func testDateFormatting() throws {
        let date = Date(timeIntervalSince1970: 1705881600) // Jan 22, 2024 00:00:00 UTC
        guard let tokyo = TimeZone(identifier: "Asia/Tokyo"),
              let ny = TimeZone(identifier: "America/New_York") else {
            throw TestError("Failed to create time zones")
        }
        let enUS = Locale(identifier: "en_US")
        
        // Test different format styles
        let dateOnly = TimeZoneUtilities.format(date: date, timeZone: tokyo, style: .dateOnly, locale: enUS)
        #expect(dateOnly.contains("Jan"))
        #expect(dateOnly.contains("2024"))
        #expect(!dateOnly.contains(":")) // Should not contain time
        
        let timeOnly = TimeZoneUtilities.format(date: date, timeZone: tokyo, style: .timeOnly, locale: enUS)
        #expect(timeOnly.contains(":"))
        #expect(!timeOnly.contains("2024")) // Should not contain date
        
        let full = TimeZoneUtilities.format(date: date, timeZone: tokyo, style: .full, locale: enUS)
        #expect(full.contains("Jan"))
        #expect(full.contains("2024"))
        #expect(full.contains(":"))
        
        // Test with Japanese locale
        let jaJP = Locale(identifier: "ja_JP")
        let jpFormat = TimeZoneUtilities.format(date: date, timeZone: tokyo, style: .full, locale: jaJP)
        #expect(jpFormat.contains("2024"))
        
        // Test formatting during DST transition
        let dstDate = Date(timeIntervalSince1970: 1710061200) // March 10, 2024 07:00:00 UTC (DST start in US)
        let beforeDST = TimeZoneUtilities.format(date: dstDate, timeZone: ny, style: .full, locale: enUS)
        let afterDST = TimeZoneUtilities.format(date: dstDate.addingTimeInterval(7200), timeZone: ny, style: .full, locale: enUS)
        #expect(beforeDST != afterDST)
    }
    
    @Test("Test GMT offset formatting")
    func testOffsetFormatting() throws {
        guard let tokyo = TimeZone(identifier: "Asia/Tokyo"),
              let ny = TimeZone(identifier: "America/New_York"),
              let utc = TimeZone(identifier: "UTC") else {
            throw TestError("Failed to create time zones")
        }
        
        // Test positive offset
        let tokyoOffset = TimeZoneUtilities.currentOffset(for: tokyo)
        #expect(tokyoOffset.hasPrefix("+"))
        #expect(tokyoOffset.contains(":"))
        
        // Test negative offset
        let nyOffset = TimeZoneUtilities.currentOffset(for: ny)
        #expect(nyOffset.contains(":"))
        
        // Test zero offset
        let utcOffset = TimeZoneUtilities.currentOffset(for: utc)
        #expect(utcOffset == "+00:00")
        
        // Test offset during DST
        // March 10, 2024 01:59:00 EST (before DST)
        let beforeDSTDate = Date(timeIntervalSince1970: 1710050340)
        // March 10, 2024 03:01:00 EDT (after DST)
        let afterDSTDate = Date(timeIntervalSince1970: 1710054060)
        
        let beforeDST = TimeZoneUtilities.currentOffset(for: ny, at: beforeDSTDate)
        let afterDST = TimeZoneUtilities.currentOffset(for: ny, at: afterDSTDate)
        #expect(beforeDST == "-05:00") // EST offset
        #expect(afterDST == "-04:00") // EDT offset
    }
    
    @Test("Test DST detection")
    func testDSTDetection() throws {
        guard let ny = TimeZone(identifier: "America/New_York"),
              let tokyo = TimeZone(identifier: "Asia/Tokyo"),
              let utc = TimeZone(identifier: "UTC") else {
            throw TestError("Failed to create time zones")
        }
        
        // Test DST observation
        let isDSTNY = TimeZoneUtilities.isDaylightSavingTime(in: ny)
        #expect(isDSTNY == ny.isDaylightSavingTime(for: Date()))
        
        // Test non-DST zones
        let isDSTTokyo = TimeZoneUtilities.isDaylightSavingTime(in: tokyo)
        #expect(!isDSTTokyo) // Tokyo doesn't observe DST
        
        let isDSTUTC = TimeZoneUtilities.isDaylightSavingTime(in: utc)
        #expect(!isDSTUTC) // UTC never observes DST
    }
    
    @Test("Test next DST transition")
    func testNextDSTTransition() throws {
        guard let ny = TimeZone(identifier: "America/New_York"),
              let tokyo = TimeZone(identifier: "Asia/Tokyo"),
              let utc = TimeZone(identifier: "UTC") else {
            throw TestError("Failed to create time zones")
        }
        
        // Test zones with DST
        let nyTransition = TimeZoneUtilities.nextDSTTransition(in: ny)
        #expect(nyTransition != nil)
        
        // Test zones without DST
        let tokyoTransition = TimeZoneUtilities.nextDSTTransition(in: tokyo)
        #expect(tokyoTransition == nil)
        
        let utcTransition = TimeZoneUtilities.nextDSTTransition(in: utc)
        #expect(utcTransition == nil)
    }
    
    @Test("Test all time zones")
    func testAllTimeZones() throws {
        let zones = TimeZoneUtilities.allTimeZones()
        
        // Test structure
        #expect(!zones.isEmpty)
        #expect(zones.keys.contains("America"))
        #expect(zones.keys.contains("Europe"))
        #expect(zones.keys.contains("Asia"))
        #expect(zones.keys.contains("Pacific"))
        #expect(zones.keys.contains("Africa"))
        
        // Test completeness
        let allSystemZones = Set(TimeZone.knownTimeZoneIdentifiers)
        var allReturnedZones = Set<String>()
        for (_, identifiers) in zones {
            allReturnedZones.formUnion(identifiers)
        }
        #expect(allReturnedZones == allSystemZones)
        
        // Test validity of identifiers
        for (_, identifiers) in zones {
            for identifier in identifiers {
                #expect(TimeZone(identifier: identifier) != nil)
            }
        }
    }
    
    @Test("Test common time zones")
    func testCommonTimeZones() throws {
        let zones = TimeZoneUtilities.commonTimeZones()
        
        // Test structure
        #expect(zones.keys.contains("America"))
        #expect(zones.keys.contains("Europe"))
        #expect(zones.keys.contains("Asia"))
        #expect(zones.keys.contains("Pacific"))
        #expect(zones.keys.contains("Africa"))
        
        // Test content
        #expect(zones["America"]?.contains("America/New_York") == true)
        #expect(zones["Europe"]?.contains("Europe/London") == true)
        #expect(zones["Asia"]?.contains("Asia/Tokyo") == true)
        #expect(zones["Pacific"]?.contains("Australia/Sydney") == true)
        #expect(zones["Africa"]?.contains("Africa/Cairo") == true)
        
        // Test validity of identifiers
        for (_, identifiers) in zones {
            for identifier in identifiers {
                let timeZone = TimeZone(identifier: identifier)
                #expect(timeZone != nil, "Invalid timezone identifier: \(identifier)")
            }
        }
        
        // Test that common zones are a subset of all zones
        let allZones = TimeZoneUtilities.allTimeZones()
        for (region, identifiers) in zones {
            let commonSet = Set(identifiers)
            var allSet = Set<String>()
            
            // Handle special cases for regions
            switch region {
            case "Pacific":
                allSet.formUnion(allZones["Pacific"] ?? [])
                allSet.formUnion(allZones["Australia"] ?? [])
            case "Asia":
                allSet.formUnion(allZones["Asia"] ?? [])
                // Handle special case for Kolkata (formerly Calcutta)
                if allSet.contains("Asia/Calcutta") {
                    allSet.insert("Asia/Kolkata")
                }
            default:
                allSet.formUnion(allZones[region] ?? [])
            }
            
            #expect(allSet.isSuperset(of: commonSet), "Common zones for \(region) are not a subset of all zones")
        }
    }
}
