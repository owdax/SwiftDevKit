# String and Date Conversion

@Metadata {
    @TechnologyRoot
}

Learn about SwiftDevKit's string and date conversion capabilities.

## Overview

SwiftDevKit provides robust and type-safe ways to convert values to and from strings through the ``StringConvertible`` and ``DateConvertible`` protocols. These features are particularly useful when working with data serialization, user input, API communication, or any scenario where you need to convert between strings and other types.

## Topics

### Essentials

- ``StringConvertible``
- ``StringConversionError``
- ``DateConvertible``
- ``DateConversionError``
- ``DateFormat``

### Common Use Cases

- Converting numeric types to strings
- Parsing strings into numeric types
- Thread-safe date formatting
- HTTP date handling
- ISO8601 date conversion
- Custom date formats
- Adding string conversion to custom types
- Handling conversion errors

### Code Examples

```swift
// Converting numbers to strings
let number = 42
let string = try await number.toString() // "42"

// Converting strings to numbers
let parsed = try await Int.fromString("42") // 42

// Custom type conversion
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

// Date conversion
let date = Date()
// ISO8601 format
let iso8601 = try await date.toISO8601() // "2025-01-16T15:30:00Z"
// HTTP date format
let httpDate = try await date.toHTTPDate() // "Wed, 16 Jan 2025 15:30:00 GMT"
// Custom format
let custom = try await date.toString(format: DateFormat.shortDate) // "01/16/2025"
```

### Error Handling

The framework provides comprehensive error handling through ``StringConversionError`` and ``DateConversionError``:

```swift
// String conversion errors
do {
    let value = try await Int.fromString("not a number")
} catch let error as StringConversionError {
    switch error {
    case .invalidInput(let value):
        print("Invalid input: \(value)")
    }
}

// Date conversion errors
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

### Best Practices

- Always handle potential conversion errors using try-catch
- Provide clear error messages in custom implementations
- Document expected string formats for custom types
- Use async/await for consistency with the protocols
- Leverage predefined date formats for common use cases
- Take advantage of thread-safe date formatting

## See Also

- ``StringConvertible``
- ``StringConversionError``
- ``DateConvertible``
- ``DateConversionError``
- ``DateFormat``
- <doc:GettingStarted> 