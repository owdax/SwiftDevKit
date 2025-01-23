# SwiftDevKit

[![Swift](https://img.shields.io/badge/Swift-6.0-orange.svg)](https://swift.org)
[![SPM](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)](https://swift.org/package-manager)
[![Platform](https://img.shields.io/badge/Platforms-iOS%20|%20macOS%20|%20tvOS%20|%20watchOS-lightgrey.svg)](https://developer.apple.com/swift/)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Status](https://img.shields.io/badge/Status-Beta-yellow.svg)]()

Think of it as your Swiss Army knife for Swift development - all the tools you need, right in your native environment.

> ⚠️ **Project Status**: Beta Release
> 
> SwiftDevKit is currently in beta. While the core features are implemented and tested, the API might undergo refinements based on feedback.
> 
> Want to contribute? Check out our [Contributing Guidelines](CONTRIBUTING.md)!

## Vision

SwiftDevKit aims to be your go-to toolkit for common development tasks, offering a wide range of functionalities from data conversion to code generation. Our goal is to provide a comprehensive, well-tested, and professionally crafted SDK that brings the power of web-based developer tools natively to Swift.

## Features

### Text Processing

SwiftDevKit provides powerful text processing tools for common string manipulation tasks:

#### String Transformations
- Case transformations (toTitleCase, toCamelCase, toSnakeCase, toKebabCase)
- Smart string truncation with customizable length and ellipsis
- Whitespace handling (removeExcessWhitespace)

#### String Extraction
- Extract numbers (with optional negative number handling)
- Extract words with minimum length filtering
- Extract sentences from text
- Extract URLs with custom scheme filtering
- Extract email addresses
- Extract hashtags and mentions (social media style)
- Extract dates from text

### Time Utilities
- Comprehensive timezone management and conversions
- Time formatting and parsing
- Date and time calculations
- Time interval operations

### Conversion Utilities
- Color conversions (RGB, HSL, HSB, Hex)
- Number formatting with locale support
- Date formatting and parsing
- Numeric string conversions
- Custom string conversion protocols

### Currently Implemented
- ✅ Text Processing (String transformations and extraction)
- ✅ Time and TimeZone utilities
- ✅ Color conversion
- ✅ Number formatting
- ✅ Date conversion

### Coming Soon
- 🔐 Cryptography utilities
- 🎨 Additional development helpers
- 📱 Platform-specific optimizations

## Requirements

- iOS 16.0+ / macOS 13.0+ / tvOS 16.0+ / watchOS 9.0+
- Xcode 16.0+
- Swift 6.0+

## Installation

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/owdax/SwiftDevKit.git", from: "0.1.0-beta.1")
]
```

### CocoaPods

```ruby
pod 'SwiftDevKit', '0.1.0-beta.1'
```

## Development Roadmap

1. 🏗 Core Infrastructure (Completed)
   - Setting up development tools ✅
   - Establishing CI/CD pipeline ✅
   - Code quality tools integration ✅

2. 🧰 Core Features (Beta)
   - Text Processing tools ✅
     - Case transformations
     - String truncation
     - Whitespace handling
   - Time and TimeZone utilities ✅
   - Color and Number conversion ✅

3. 🔒 Advanced Features (Planned)
   - Cryptography utilities
   - Platform-specific optimizations
   - Advanced debugging tools

## Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details.

## Community

- If you have any questions, open an [issue](https://github.com/owdax/SwiftDevKit/issues/new)
- For feature requests, open an [issue](https://github.com/owdax/SwiftDevKit/issues/new) with the `enhancement` label
- Found a bug? Open an [issue](https://github.com/owdax/SwiftDevKit/issues/new) with the `bug` label

## License

SwiftDevKit is available under the MIT license. See the [LICENSE](LICENSE) file for more info.

## Acknowledgments

