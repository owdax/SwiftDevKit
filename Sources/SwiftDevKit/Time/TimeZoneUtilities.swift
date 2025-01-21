// TimeZoneUtilities.swift
// SwiftDevKit
//
// Copyright (c) 2025 owdax and The SwiftDevKit Contributors
// MIT License - https://opensource.org/licenses/MIT

import Foundation

/// A utility for handling time zone conversions and formatting dates across different time zones.
public enum TimeZoneUtilities {
    /// Style options for date and time formatting
    public enum FormatStyle {
        /// Date only (e.g., "Jan 21, 2025")
        case dateOnly
        /// Time only (e.g., "14:30")
        case timeOnly
        /// Date and time (e.g., "Jan 21, 2025 14:30")
        case full
        /// Short style (e.g., "1/21/25 14:30")
        case short
        /// Long style (e.g., "January 21, 2025 at 2:30 PM")
        case long
    }

    /// Converts a date from one time zone to another, handling DST transitions.
    ///
    /// This function is useful when you need to display or process dates in different time zones.
    /// The returned date represents the same instant in time, just expressed in a different time zone.
    /// It properly handles Daylight Saving Time (DST) transitions.
    ///
    /// Examples:
    /// ```swift
    /// let nyTime = Date() // Current time in New York
    /// let nyZone = TimeZone(identifier: "America/New_York")!
    /// let tokyoZone = TimeZone(identifier: "Asia/Tokyo")!
    ///
    /// // Convert NY time to Tokyo time
    /// let tokyoTime = TimeZoneUtilities.convert(date: date, from: nyZone, to: tokyoZone)
    /// ```
    ///
    /// - Parameters:
    ///   - date: The date to convert
    ///   - fromZone: The source time zone
    ///   - toZone: The target time zone
    /// - Returns: The converted date
    public static func convert(date: Date, from fromZone: TimeZone, to toZone: TimeZone) -> Date {
        let sourceSeconds = fromZone.secondsFromGMT(for: date)
        let destinationSeconds = toZone.secondsFromGMT(for: date)
        let interval = TimeInterval(destinationSeconds - sourceSeconds)

        return date.addingTimeInterval(interval)
    }

    /// Formats a date for a specific time zone with the given style.
    ///
    /// This function is useful when you need to display dates in a specific time zone's format.
    /// The output format varies based on the style parameter and respects the provided locale.
    /// It automatically handles DST transitions and adjusts the output accordingly.
    ///
    /// Examples:
    /// ```swift
    /// let now = Date()
    /// let tokyoZone = TimeZone(identifier: "Asia/Tokyo")!
    ///
    /// // Different format styles
    /// TimeZoneUtilities.format(date: now, timeZone: tokyoZone, style: .dateOnly)  // "Jan 21, 2025"
    /// TimeZoneUtilities.format(date: now, timeZone: tokyoZone, style: .timeOnly)  // "14:30"
    /// TimeZoneUtilities.format(date: now, timeZone: tokyoZone, style: .full)      // "Jan 21, 2025 14:30"
    /// TimeZoneUtilities.format(date: now, timeZone: tokyoZone, style: .short)     // "1/21/25 14:30"
    /// TimeZoneUtilities.format(date: now, timeZone: tokyoZone, style: .long)      // "January 21, 2025 at 2:30 PM"
    ///
    /// // With different locale
    /// let japaneseLocale = Locale(identifier: "ja_JP")
    /// TimeZoneUtilities.format(date: now, timeZone: tokyoZone, style: .full, locale: japaneseLocale)
    /// ```
    ///
    /// - Parameters:
    ///   - date: The date to format
    ///   - timeZone: The time zone to use for formatting
    ///   - style: The formatting style to use
    ///   - locale: The locale to use for formatting (default: current)
    /// - Returns: A formatted string representing the date in the specified time zone
    public static func format(
        date: Date,
        timeZone: TimeZone,
        style: FormatStyle,
        locale: Locale = .current) -> String
    {
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.locale = locale

        switch style {
            case .dateOnly:
                formatter.dateStyle = .medium
                formatter.timeStyle = .none
            case .timeOnly:
                formatter.dateStyle = .none
                formatter.timeStyle = .short
            case .full:
                formatter.dateStyle = .medium
                formatter.timeStyle = .short
            case .short:
                formatter.dateStyle = .short
                formatter.timeStyle = .short
            case .long:
                formatter.dateStyle = .long
                formatter.timeStyle = .long
        }

        return formatter.string(from: date)
    }

    /// Returns a list of all available time zone identifiers grouped by region.
    ///
    /// This function provides access to all time zones supported by the system,
    /// organized by geographical region for easier navigation.
    ///
    /// Example:
    /// ```swift
    /// let zones = TimeZoneUtilities.allTimeZones()
    /// for (region, identifiers) in zones {
    ///     print("Region: \(region)")
    ///     for identifier in identifiers {
    ///         print("  - \(identifier)")
    ///     }
    /// }
    /// ```
    ///
    /// - Returns: A dictionary with regions as keys and arrays of time zone identifiers as values
    public static func allTimeZones() -> [String: [String]] {
        var regions: [String: [String]] = [:]

        for identifier in TimeZone.knownTimeZoneIdentifiers.sorted() {
            let components = identifier.split(separator: "/")
            if components.count >= 2 {
                let region = String(components[0])
                regions[region, default: []].append(identifier)
            } else {
                regions["Other", default: []].append(identifier)
            }
        }

        return regions
    }

    /// Returns commonly used time zone identifiers grouped by region.
    ///
    /// This function provides a curated list of frequently used time zones,
    /// organized by geographical region for easier selection.
    ///
    /// Example:
    /// ```swift
    /// let zones = TimeZoneUtilities.commonTimeZones()
    /// for (region, identifiers) in zones {
    ///     print("Region: \(region)")
    ///     for identifier in identifiers {
    ///         print("  - \(identifier)")
    ///     }
    /// }
    /// ```
    ///
    /// - Returns: A dictionary with regions as keys and arrays of time zone identifiers as values
    public static func commonTimeZones() -> [String: [String]] {
        let common = [
            "America": [
                "America/New_York",
                "America/Los_Angeles",
                "America/Chicago",
                "America/Toronto",
                "America/Vancouver",
                "America/Mexico_City",
                "America/Sao_Paulo",
                "America/Argentina/Buenos_Aires",
            ],
            "Europe": [
                "Europe/London",
                "Europe/Paris",
                "Europe/Berlin",
                "Europe/Rome",
                "Europe/Madrid",
                "Europe/Amsterdam",
                "Europe/Moscow",
                "Europe/Istanbul",
            ],
            "Asia": [
                "Asia/Tokyo",
                "Asia/Shanghai",
                "Asia/Singapore",
                "Asia/Dubai",
                "Asia/Hong_Kong",
                "Asia/Seoul",
                "Asia/Kolkata",
                "Asia/Bangkok",
            ],
            "Pacific": [
                "Australia/Sydney",
                "Pacific/Auckland",
                "Australia/Melbourne",
                "Pacific/Honolulu",
                "Pacific/Fiji",
                "Pacific/Guam",
            ],
            "Africa": [
                "Africa/Cairo",
                "Africa/Lagos",
                "Africa/Johannesburg",
                "Africa/Nairobi",
                "Africa/Casablanca",
            ],
        ]

        return common
    }

    /// Returns the GMT offset for a given time zone at a specific date.
    ///
    /// This function returns a string representation of the time zone's offset from GMT,
    /// taking into account Daylight Saving Time if applicable for the given date.
    ///
    /// Examples:
    /// ```swift
    /// let ny = TimeZone(identifier: "America/New_York")!
    /// let date = Date()
    ///
    /// // Get current offset
    /// TimeZoneUtilities.currentOffset(for: ny, at: date) // "-05:00" or "-04:00" depending on DST
    /// ```
    ///
    /// - Parameters:
    ///   - timeZone: The time zone to get the offset for
    ///   - date: The date at which to check the offset (default: current date)
    /// - Returns: A string representation of the GMT offset (e.g., "+09:00", "-05:00")
    public static func currentOffset(for timeZone: TimeZone, at date: Date = Date()) -> String {
        let seconds = timeZone.secondsFromGMT(for: date)
        let hours = abs(seconds) / 3600
        let minutes = (abs(seconds) % 3600) / 60
        let sign = seconds >= 0 ? "+" : "-"
        return String(format: "%@%02d:%02d", sign, hours, minutes)
    }

    /// Checks if a time zone is currently observing Daylight Saving Time.
    ///
    /// This function determines whether a given time zone is currently in DST.
    ///
    /// Example:
    /// ```swift
    /// let nyZone = TimeZone(identifier: "America/New_York")!
    /// let isDST = TimeZoneUtilities.isDaylightSavingTime(in: nyZone) // true during DST
    /// ```
    ///
    /// - Parameter timeZone: The time zone to check
    /// - Returns: true if the time zone is currently observing DST, false otherwise
    public static func isDaylightSavingTime(in timeZone: TimeZone) -> Bool {
        timeZone.isDaylightSavingTime(for: Date())
    }

    /// Gets the next DST transition date for a given time zone.
    ///
    /// This function finds the next date when the time zone will transition
    /// either into or out of Daylight Saving Time.
    ///
    /// Example:
    /// ```swift
    /// let nyZone = TimeZone(identifier: "America/New_York")!
    /// if let nextTransition = TimeZoneUtilities.nextDSTTransition(in: nyZone) {
    ///     print("Next DST transition: \(nextTransition)")
    /// }
    /// ```
    ///
    /// - Parameter timeZone: The time zone to check
    /// - Returns: The next DST transition date, or nil if the time zone doesn't observe DST
    public static func nextDSTTransition(in timeZone: TimeZone) -> Date? {
        timeZone.nextDaylightSavingTimeTransition
    }
}
