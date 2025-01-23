# Getting Started with SwiftDevKit

Learn how to use SwiftDevKit's powerful features for text processing, time utilities, and data conversion.

## Overview

SwiftDevKit provides a comprehensive set of tools for common development tasks, including string manipulation, time handling, and various data conversion utilities.

## Requirements

- iOS 13.0+ / macOS 10.15+ / tvOS 13.0+ / watchOS 6.0+
- Xcode 16.0+
- Swift 5.9+

## Basic Setup

Add SwiftDevKit to your project using Swift Package Manager:

```swift
dependencies: [
    .package(url: "https://github.com/owdax/SwiftDevKit.git", from: "1.0.0")
]
```

## Text Processing

### String Transformations

```swift
let text = "hello world example"
let camelCase = text.toCamelCase() // "helloWorldExample"
let snakeCase = text.toSnakeCase() // "hello_world_example"
let kebabCase = text.toKebabCase() // "hello-world-example"

// Smart truncation
let longText = "This is a very long text that needs truncation"
let truncated = longText.truncate(length: 20) // "This is a very lon..."

// Whitespace handling
let messy = "  too   many    spaces   "
let clean = messy.removeExcessWhitespace() // "too many spaces"
```

### String Extraction

```swift
let text = "Contact us at support@example.com or visit https://example.com"
let emails = text.extractEmails() // ["support@example.com"]
let urls = text.extractURLs() // ["https://example.com"]

let post = "Check out #swiftdev and @swift_dev for updates!"
let hashtags = post.extractHashtags() // ["swiftdev"]
let mentions = post.extractMentions() // ["swift_dev"]
```

## Time Utilities

### TimeZone Management

```swift
// Get current time in different zones
let time = TimeZoneUtilities.currentTime(in: "America/New_York")
let offset = TimeZoneUtilities.offsetHours(for: "Europe/London")

// Convert between zones
let converted = TimeZoneUtilities.convert(date: Date(),
                                        from: "UTC",
                                        to: "Asia/Tokyo")
```

## Color Conversion

```swift
// Convert between color formats
let rgb = RGBColor(r: 255, g: 128, b: 0)
let hex = rgb.toHex() // "#FF8000"
let hsl = rgb.toHSL() // HSLColor(h: 30, s: 100, l: 50)

// Parse colors
let color = try ColorConversion.from(hex: "#FF8000")
let rgbComponents = color.rgbComponents
```

## Number Formatting

```swift
let number = 1234567.89
let formatted = number.format(style: .currency,
                            locale: Locale(identifier: "en_US"))
// "$1,234,567.89"

let scientific = number.format(style: .scientific)
// "1.23E6"
```

## Error Handling

Handle conversion errors appropriately:

```swift
do {
    let color = try ColorConversion.from(hex: "invalid")
} catch let error as ColorConversionError {
    print("Invalid color format: \(error.localizedDescription)")
}

do {
    let time = try TimeZoneUtilities.convert(date: Date(),
                                           from: "Invalid/Zone",
                                           to: "UTC")
} catch let error as TimeZoneError {
    print("Time zone error: \(error.localizedDescription)")
}
```

## Next Steps

- Explore the API documentation for detailed information
- Check out example projects in the repository
- Join our community discussions

For more information, visit the [SwiftDevKit Documentation](https://github.com/owdax/SwiftDevKit). 