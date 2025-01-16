# Getting Started with SwiftDevKit

This guide helps you get started with string and date conversion features in SwiftDevKit.

## Overview

SwiftDevKit provides simple and type-safe ways to convert values to and from strings, including specialized support for date formatting with thread safety.

## Requirements

- iOS 16.0+ / macOS 13.0+ / tvOS 16.0+ / watchOS 9.0+
- Swift 5.9+

## Basic Setup

Add SwiftDevKit to your project using Swift Package Manager:

```swift
dependencies: [
    .package(url: "https://github.com/yourusername/SwiftDevKit.git", from: "1.0.0")
]
```

## Using String Conversion

### Built-in Types

SwiftDevKit extends common numeric types with string conversion capabilities:

```swift
let number = 42
let string = try await number.toString() // "42"
let backToNumber = try await Int.fromString("42") // 42
```

### Custom Types

Make your types string-convertible by conforming to `StringConvertible`:

```swift
struct User: StringConvertible {
    let id: Int
    
    func toString() async throws -> String {
        return String(id)
    }
    
    static func fromString(_ string: String) async throws -> Self {
        guard let id = Int(string) else {
            throw StringConversionError.invalidInput(string)
        }
        return User(id: id)
    }
}
```

## Date Conversion

SwiftDevKit provides thread-safe date formatting with common predefined formats:

```swift
// Using ISO8601
let date = Date()
let iso8601 = try await date.toISO8601() // "2025-01-16T15:30:00Z"
let parsedDate = try await Date.fromISO8601(iso8601)

// Using custom formats
let shortDate = try await date.toString(format: DateFormat.shortDate) // "01/16/2025"
let httpDate = try await date.toHTTPDate() // "Wed, 16 Jan 2025 15:30:00 GMT"
```

### Predefined Date Formats

SwiftDevKit includes commonly used date formats:
- `DateFormat.iso8601` - Standard format for APIs
- `DateFormat.http` - For HTTP headers
- `DateFormat.shortDate` - Compact display format
- `DateFormat.longDate` - Human-readable format
- `DateFormat.dateTime` - Combined date and time
- And more...

### Thread Safety

All date conversion operations are thread-safe and can be called concurrently from multiple tasks. The framework uses an actor-based formatter cache to ensure optimal performance while maintaining thread safety.

## Error Handling

Handle conversion errors appropriately:

```swift
do {
    let value = try await Int.fromString("not a number")
} catch let error as StringConversionError {
    switch error {
    case .invalidInput(let value):
        print("Invalid input: \(value)")
    }
}

do {
    let date = try await Date.fromString("invalid", format: DateFormat.iso8601)
} catch let error as DateConversionError {
    switch error {
    case .invalidFormat(let value):
        print("Invalid date format: \(value)")
    case .invalidComponents:
        print("Invalid date components")
    case .invalidFormatString(let format):
        print("Invalid format string: \(format)")
    case .custom(let message):
        print(message)
    }
}
```

## Next Steps

- Explore the API documentation for more details
- Check out example projects in the repository
- Join our community discussions

For more information, visit the [SwiftDevKit Documentation](https://github.com/yourusername/SwiftDevKit). 