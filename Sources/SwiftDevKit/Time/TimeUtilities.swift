// TimeUtilities.swift
// SwiftDevKit
//
// Copyright (c) 2025 owdax and The SwiftDevKit Contributors
// MIT License - https://opensource.org/licenses/MIT

import Foundation

/// A utility for handling time-related operations with a focus on human-readable formats
/// and common time calculations.
///
/// TimeUtilities provides a set of static functions for:
/// - Formatting relative times (e.g., "2 hours ago", "in 3 days")
/// - Formatting durations (e.g., "2 hours, 30 minutes")
/// - Calculating time remaining
/// - Checking if dates are within specific time ranges
public enum TimeUtilities {
    /// Style options for relative time formatting
    public enum RelativeTimeStyle {
        /// Short style (e.g., "2h", "3d", "1y")
        case short
        /// Medium style (e.g., "2 hours", "3 days", "1 year")
        case medium
        /// Long style with multiple components (e.g., "2 hours and 30 minutes", "3 days and 12 hours")
        case long
        /// Precise style with all components (e.g., "2 hours, 30 minutes, and 15 seconds")
        case precise
    }

    /// Units available for time calculations
    public enum TimeUnit {
        case seconds
        case minutes
        case hours
        case days
        case weeks
        case months
        case years

        var calendarComponent: Calendar.Component {
            switch self {
                case .seconds: .second
                case .minutes: .minute
                case .hours: .hour
                case .days: .day
                case .weeks: .weekOfMonth
                case .months: .month
                case .years: .year
            }
        }
    }

    /// Formats a date relative to the current time in a human-readable format.
    ///
    /// This function is useful for displaying how long ago something happened or how far in the future it will occur.
    /// The output format varies based on the style parameter and whether the date is in the past or future.
    ///
    /// Examples:
    /// ```swift
    /// // Past dates
    /// let twoHoursAgo = Date().addingTimeInterval(-7200)
    /// TimeUtilities.relativeTime(from: twoHoursAgo, style: .short)  // "2h"
    /// TimeUtilities.relativeTime(from: twoHoursAgo, style: .medium) // "2 hours"
    ///
    /// // Future dates
    /// let inOneHour = Date().addingTimeInterval(3600)
    /// TimeUtilities.relativeTime(from: inOneHour, style: .short)  // "in 1h"
    /// TimeUtilities.relativeTime(from: inOneHour, style: .medium) // "in 1 hour"
    ///
    /// // Current time
    /// TimeUtilities.relativeTime(from: Date(), style: .medium) // "just now"
    /// ```
    ///
    /// - Parameters:
    ///   - date: The date to format
    ///   - style: The style of the relative time string (default: .medium)
    ///   - locale: The locale to use for formatting (default: current)
    /// - Returns: A string representing the relative time
    public static func relativeTime(
        from date: Date,
        style: RelativeTimeStyle,
        locale: Locale = .current) -> String
    {
        let now = Date()
        let calendar = Calendar.current
        let components: Set<Calendar.Component> = [.year, .month, .weekOfMonth, .day, .hour, .minute, .second]
        let diffComponents = calendar.dateComponents(components, from: date, to: now)

        let formatter = DateComponentsFormatter()
        formatter.calendar = calendar
        formatter.unitsStyle = style == .short ? .abbreviated : .full
        formatter.allowedUnits = [.year, .month, .weekOfMonth, .day, .hour, .minute, .second]
        formatter.maximumUnitCount = 1

        if date > now {
            let interval = date.timeIntervalSince(now)
            return "in " + (formatter.string(from: interval) ?? "")
        }

        if let years = diffComponents.year, years > 0 {
            return formatter.string(from: TimeInterval(years * 31_536_000)) ?? ""
        }
        if let months = diffComponents.month, months > 0 {
            return formatter.string(from: TimeInterval(months * 2_592_000)) ?? ""
        }
        if let weeks = diffComponents.weekOfMonth, weeks > 0 {
            return formatter.string(from: TimeInterval(weeks * 604_800)) ?? ""
        }
        if let days = diffComponents.day, days > 0 {
            return formatter.string(from: TimeInterval(days * 86400)) ?? ""
        }
        if let hours = diffComponents.hour, hours > 0 {
            return formatter.string(from: TimeInterval(hours * 3600)) ?? ""
        }
        if let minutes = diffComponents.minute, minutes > 0 {
            return formatter.string(from: TimeInterval(minutes * 60)) ?? ""
        }

        return "just now"
    }

    /// Formats a time duration in a human-readable format.
    ///
    /// This function is useful for displaying durations like video lengths, time spent, or time remaining.
    /// The output format varies based on the style parameter and the duration length.
    ///
    /// Examples:
    /// ```swift
    /// // Short durations
    /// TimeUtilities.formatDuration(seconds: 45, style: .short)     // "45s"
    /// TimeUtilities.formatDuration(seconds: 45, style: .medium)    // "45 seconds"
    ///
    /// // Medium durations
    /// TimeUtilities.formatDuration(seconds: 3665, style: .medium)  // "1 hour"
    /// TimeUtilities.formatDuration(seconds: 3665, style: .long)    // "1 hour, 1 minute"
    ///
    /// // Long durations with different styles
    /// let duration = 7384 // 2 hours, 3 minutes, 4 seconds
    /// TimeUtilities.formatDuration(seconds: duration, style: .short)    // "2h"
    /// TimeUtilities.formatDuration(seconds: duration, style: .medium)   // "2 hours"
    /// TimeUtilities.formatDuration(seconds: duration, style: .long)     // "2 hours, 3 minutes"
    /// TimeUtilities.formatDuration(seconds: duration, style: .precise)  // "2 hours, 3 minutes, 4 seconds"
    /// ```
    ///
    /// - Parameters:
    ///   - seconds: The duration in seconds
    ///   - style: The formatting style to use (default: .medium)
    ///   - locale: The locale to use for formatting (default: current)
    /// - Returns: A formatted string representing the duration
    public static func formatDuration(
        seconds: TimeInterval,
        style: RelativeTimeStyle = .medium,
        locale: Locale = .current) -> String
    {
        let formatter = DateComponentsFormatter()
        formatter.calendar = Calendar.current
        formatter.allowedUnits = [.year, .month, .weekOfMonth, .day, .hour, .minute, .second]
        formatter.maximumUnitCount = style == .precise ? 6 : (style == .long ? 2 : 1)
        formatter.unitsStyle = style == .short ? .abbreviated : .full

        return formatter.string(from: seconds) ?? "\(Int(seconds))s"
    }

    /// Calculates and formats the time remaining until a future date.
    ///
    /// This function is useful for countdown displays or showing time remaining until an event.
    /// Returns nil if the provided date is in the past.
    ///
    /// Examples:
    /// ```swift
    /// // Future dates
    /// let twoHoursLater = Date().addingTimeInterval(7200)
    /// TimeUtilities.timeRemaining(until: twoHoursLater, style: .short)     // "2h"
    /// TimeUtilities.timeRemaining(until: twoHoursLater, style: .medium)    // "2 hours"
    /// TimeUtilities.timeRemaining(until: twoHoursLater, style: .long)      // "2 hours"
    ///
    /// // Past dates
    /// let oneHourAgo = Date().addingTimeInterval(-3600)
    /// TimeUtilities.timeRemaining(until: oneHourAgo) // nil
    /// ```
    ///
    /// - Parameters:
    ///   - date: The future date
    ///   - style: The formatting style to use (default: .medium)
    ///   - locale: The locale to use for formatting (default: current)
    /// - Returns: A string representing the time remaining, or nil if the date is in the past
    public static func timeRemaining(
        until date: Date,
        style: RelativeTimeStyle = .medium,
        locale: Locale = .current) -> String?
    {
        let now = Date()
        guard date > now else { return nil }

        let seconds = date.timeIntervalSince(now)
        return formatDuration(seconds: seconds, style: style, locale: locale)
    }

    /// Checks if a date is within a specified time unit from now.
    ///
    /// This function is useful for determining if something happened recently or is coming up soon.
    /// For example, checking if a message was sent within the last hour or if an event is within the next week.
    ///
    /// Examples:
    /// ```swift
    /// // Check recent events
    /// let oneHourAgo = Date().addingTimeInterval(-3600)
    /// TimeUtilities.isWithin(date: oneHourAgo, unit: .hours, value: 2)    // true
    /// TimeUtilities.isWithin(date: oneHourAgo, unit: .minutes, value: 30) // false
    ///
    /// // Check upcoming events
    /// let threeDaysLater = Date().addingTimeInterval(259200)
    /// TimeUtilities.isWithin(date: threeDaysLater, unit: .days, value: 2)  // false
    /// TimeUtilities.isWithin(date: threeDaysLater, unit: .weeks, value: 1) // true
    ///
    /// // Edge cases
    /// let exactlyTwoHours = Date().addingTimeInterval(-7200)
    /// TimeUtilities.isWithin(date: exactlyTwoHours, unit: .hours, value: 2) // true
    /// ```
    ///
    /// - Parameters:
    ///   - date: The date to check
    ///   - unit: The time unit to use for comparison
    ///   - value: The number of units to check within
    /// - Returns: True if the date is within the specified time range
    public static func isWithin(date: Date, unit: TimeUnit, value: Int) -> Bool {
        let now = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([unit.calendarComponent], from: date, to: now)

        guard let difference = components.value(for: unit.calendarComponent) else {
            return false
        }

        return abs(difference) <= value
    }
}
