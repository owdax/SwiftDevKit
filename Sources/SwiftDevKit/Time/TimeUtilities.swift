// TimeUtilities.swift
// SwiftDevKit
//
// Copyright (c) 2025 owdax and The SwiftDevKit Contributors
// MIT License - https://opensource.org/licenses/MIT

import Foundation

/// A utility for handling time-related operations with a focus on human-readable formats
/// and common time calculations.
public enum TimeUtilities {
    /// Style options for relative time formatting
    public enum RelativeTimeStyle {
        /// Short style (e.g., "2h ago", "in 3d")
        case short
        /// Medium style (e.g., "2 hours ago", "in 3 days")
        case medium
        /// Long style (e.g., "2 hours and 30 minutes ago", "in 3 days and 12 hours")
        case long
        /// Precise style with all components (e.g., "2 hours, 30 minutes, and 15 seconds ago")
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

    /// Formats a date relative to the current time.
    ///
    /// Example:
    /// ```swift
    /// let date = Date().addingTimeInterval(-7200) // 2 hours ago
    /// let relative = TimeUtilities.relativeTime(from: date, style: .medium)
    /// print(relative) // "2 hours ago"
    /// ```
    ///
    /// - Parameters:
    ///   - date: The date to format
    ///   - style: The style of the relative time string
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
    /// Example:
    /// ```swift
    /// let duration = TimeUtilities.formatDuration(seconds: 7384) // "2 hours, 3 minutes"
    /// ```
    ///
    /// - Parameters:
    ///   - seconds: The duration in seconds
    ///   - style: The formatting style to use
    ///   - locale: The locale to use for formatting
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

    /// Calculates the time remaining until a future date.
    ///
    /// Example:
    /// ```swift
    /// let future = Date().addingTimeInterval(7200)
    /// let remaining = TimeUtilities.timeRemaining(until: future) // "2 hours"
    /// ```
    ///
    /// - Parameters:
    ///   - date: The future date
    ///   - style: The formatting style to use
    ///   - locale: The locale to use for formatting
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
    /// Example:
    /// ```swift
    /// let date = Date().addingTimeInterval(-3600) // 1 hour ago
    /// let isRecent = TimeUtilities.isWithin(date: date, unit: .hours, value: 2) // true
    /// ```
    ///
    /// - Parameters:
    ///   - date: The date to check
    ///   - unit: The time unit to use for comparison
    ///   - value: The number of units
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
