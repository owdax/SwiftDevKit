# SwiftDevKit

[![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg)](https://swift.org)
[![SPM](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)](https://swift.org/package-manager)
[![Platform](https://img.shields.io/badge/Platforms-iOS%20|%20macOS%20|%20tvOS%20|%20watchOS-lightgrey.svg)](https://developer.apple.com/swift/)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Status](https://img.shields.io/badge/Status-In%20Development-yellow.svg)]()

Think of it as your Swiss Army knife for Swift development - all the tools you need, right in your native environment.

> ⚠️ **Project Status**: Active Development
> 
> SwiftDevKit is currently in active development. The API is unstable and subject to change. While we're working hard to make it production-ready, it's not recommended for production use yet.
> 
> Want to contribute? Check out our [Contributing Guidelines](CONTRIBUTING.md)!

## Vision

SwiftDevKit aims to be your go-to toolkit for common development tasks, offering a wide range of functionalities from data conversion to code generation. Our goal is to provide a comprehensive, well-tested, and professionally crafted SDK that brings the power of web-based developer tools natively to Swift.

## Features

### Text Processing

Transform and manipulate strings with ease:

```swift
// Case transformations
"hello world".toTitleCase()      // "Hello World"
"hello world".toCamelCase()      // "helloWorld"
"hello world".toSnakeCase()      // "hello_world"
"hello world".toKebabCase()      // "hello-world"

// String truncation
let text = "This is a long text that needs to be truncated"
text.truncate(length: 10)              // "This i..."
text.truncate(length: 20)              // "This is a long t..."
text.truncate(length: 10, ellipsis: "…") // "This is…"
text.truncate(length: 10, ellipsis: "")  // "This is a"

// Whitespace handling
"hello   world".removeExcessWhitespace()  // "hello world"
```

### More Features Coming Soon
- 🔄 Data conversion tools
- 🔐 Cryptography utilities
- 🎨 Development helpers
- 📱 Platform-specific optimizations

## Requirements

- iOS 13.0+ / macOS 10.15+ / tvOS 13.0+ / watchOS 6.0+
- Xcode 16.0+
- Swift 5.9+

## Installation

> ⚠️ Note: These installation methods will be available once we reach our first stable release.

### Swift Package Manager (Coming Soon)

```swift
dependencies: [
    .package(url: "https://github.com/owdax/SwiftDevKit.git", from: "1.0.0")
]
```

### CocoaPods (Coming Soon)

```ruby
pod 'SwiftDevKit'
```

## Development Roadmap

1. 🏗 Core Infrastructure (In Progress)
   - Setting up development tools ✅
   - Establishing CI/CD pipeline ✅
   - Code quality tools integration ✅

2. 🧰 Core Features (In Progress)
   - Text Processing tools ✅
     - Case transformations
     - String truncation
     - Whitespace handling
   - Data Conversion utilities (Planned)
   - Development helpers (Planned)

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

This project is maintained by [@owdax](https://github.com/owdax) and the SwiftDevKit Contributors. We appreciate all contributions, big and small. 