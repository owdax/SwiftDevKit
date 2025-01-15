# Getting Started with SwiftDevKit

Learn how to integrate and start using SwiftDevKit in your projects.

## Overview

SwiftDevKit is designed to be easy to integrate and use in your Swift projects. This guide will help you get started with the basic setup and show you how to use some of the core features.

## Requirements

- iOS 13.0+ / macOS 10.15+ / tvOS 13.0+ / watchOS 6.0+
- Xcode 16.0+
- Swift 5.9+

## Basic Setup

First, import SwiftDevKit in your source files:

```swift
import SwiftDevKit
```

### Version Check

You can verify the version of SwiftDevKit you're using:

```swift
let version = SwiftDevKit.version
print("Using SwiftDevKit version: \(version)")
```

### Platform Support

SwiftDevKit automatically validates if your current environment meets the minimum requirements:

```swift
if SwiftDevKit.isEnvironmentValid {
    // Safe to use SwiftDevKit features
} else {
    // Handle unsupported platform
}
```

## Next Steps

- Check out the <doc:Installation> guide for detailed installation instructions
- Explore the different categories of utilities available
- Read through the API documentation for specific features
- Visit our [GitHub repository](https://github.com/owdax/SwiftDevKit) for the latest updates 