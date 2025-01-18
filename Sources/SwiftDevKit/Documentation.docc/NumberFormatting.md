# Number Formatting

Format numbers in various styles with localization support.

## Overview

SwiftDevKit provides comprehensive number formatting capabilities through the ``NumberFormattable`` protocol. This includes basic decimal formatting, scientific notation, percentages, currencies, and specialized formats like file sizes, durations, fractions, and units.

## Topics

### Basic Formatting

```swift
let number = 1234.5678

// Basic formatting (2 decimals, with grouping)
try number.formatted()  // "1,234.57"

// Custom decimals
try number.formatted(decimals: 4)  // "1,234.5678"

// Without grouping
try number.formatted(grouping: false)  // "1234.57"
```

### File Size Formatting

Format numbers as file sizes with automatic unit selection:

```swift
let bytes = 1_234_567_890

// Default file style
try bytes.asFileSize()  // "1.23 GB"

// Memory style (binary units)
try bytes.asFileSize(style: .memory)  // "1.15 GiB"

// Without unit
try bytes.asFileSize(includeUnit: false)  // "1.23"
```

### Duration Formatting

Convert numbers to time durations with various styles:

```swift
let seconds = 9045  // 2h 30m 45s

// Abbreviated style
try seconds.asDuration()  // "2h 30m"

// Full style
try seconds.asDuration(style: .full)  // "2 hours, 30 minutes"

// Different locale
let germanLocale = Locale(identifier: "de_DE")
try seconds.asDuration(style: .full, locale: germanLocale)  // "2 Stunden, 30 Minuten"
```

### Fraction Formatting

Convert decimal numbers to fractions:

```swift
// Simple fractions
try 1.5.asFraction()  // "1 1/2"
try 0.75.asFraction()  // "3/4"
try 0.333.asFraction()  // "1/3"

// Custom max denominator
try 0.333.asFraction(maxDenominator: 2)  // "1/2"

// Mixed numbers
try 2.75.asFraction()  // "2 3/4"
```

### Unit Formatting

Format numbers with various measurement units:

```swift
// Length measurements
try 5.2.asUnit(.meters)      // "5.2 m"
try 5.2.asUnit(.kilometers)  // "5.2 km"

// Different styles
try 5.2.asUnit(.kilometers, style: .short)  // "5.2km"
try 5.2.asUnit(.kilometers, style: .long)   // "5.2 kilometers"

// Weight measurements
try 75.5.asUnit(.kilograms)  // "75.5 kg"
try 75.5.asUnit(.pounds)     // "75.5 lb"

// Temperature
try 23.5.asUnit(.celsius)     // "23.5°C"
try 23.5.asUnit(.fahrenheit)  // "74.3°F"
```

## Localization

All formatting methods support localization through the `locale` parameter:

```swift
let germanLocale = Locale(identifier: "de_DE")

// Numbers
try 1234.56.formatted(locale: germanLocale)  // "1.234,56"

// File sizes
try 1_234_567_890.asFileSize(locale: germanLocale)  // "1,23 GB"

// Durations
try 9045.asDuration(style: .full, locale: germanLocale)  // "2 Stunden, 30 Minuten"

// Units
try 5.2.asUnit(.kilometers, style: .long, locale: germanLocale)  // "5,2 Kilometer"
```

## Error Handling

All formatting methods can throw ``NumberFormattingError`` in case of invalid input:

```swift
do {
    let result = try invalidNumber.asUnit(.meters)
} catch NumberFormattingError.invalidNumber(let message) {
    print("Invalid number: \(message)")
} catch NumberFormattingError.invalidOptions(let message) {
    print("Invalid options: \(message)")
} catch {
    print("Unexpected error: \(error)")
}
```

## Platform Support

Most formatting features are available on all platforms. However, some features have specific version requirements:

- Unit formatting requires macOS 12.0+, iOS 15.0+, watchOS 8.0+, or tvOS 15.0+
- Compact notation requires macOS 11.0+, iOS 14.0+, watchOS 7.0+, or tvOS 14.0+

## See Also

- ``NumberFormattable``
- ``NumberFormattingError`` 