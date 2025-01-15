# String Conversion

Convert values to and from their string representations with type safety and error handling.

## Overview

The String Conversion module provides a standardized way to convert values between their string representations and native types. It follows SOLID principles and provides type-safe conversions with comprehensive error handling.

### Key Features

- Protocol-based design following Interface Segregation Principle
- Type-safe conversions with clear error handling
- Built-in support for numeric types
- Extensible for custom types
- Comprehensive test coverage

## Topics

### Essentials

- ``StringConvertible``
- ``StringConversionError``

### Basic Usage

```swift
// Converting to string
let number = 42
let stringValue = try number.toString() // "42"

// Converting from string
let value = try Int.fromString("42") // 42

// Error handling
do {
    let invalid = try Int.fromString("not a number")
} catch StringConversionError.invalidInput(let value) {
    print("Invalid input: \(value)")
}
```

### Best Practices

When implementing `StringConvertible` for your custom types:

1. Provide clear error cases
2. Handle edge cases appropriately
3. Document conversion format requirements
4. Include validation in `fromString`
5. Maintain round-trip consistency

```swift
extension MyCustomType: StringConvertible {
    func toString() throws -> String {
        // Implement conversion to string
    }
    
    static func fromString(_ string: String) throws -> Self {
        // Implement conversion from string
        // Include proper validation
        // Handle edge cases
    }
}
```

### Error Handling

The module uses `StringConversionError` to handle common conversion errors:

- `.invalidInput`: The input string is not valid for the requested conversion
- `.unsupportedConversion`: The conversion operation is not supported
- `.custom`: Custom error cases with specific messages

### Thread Safety

All conversion operations are thread-safe and can be used in concurrent environments. 