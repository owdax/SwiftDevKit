# Installing SwiftDevKit

Learn how to add SwiftDevKit to your Swift projects.

## Overview

SwiftDevKit can be installed using Swift Package Manager or CocoaPods. Choose the method that best fits your project's needs.

## Swift Package Manager

### Using Xcode

1. In Xcode, select File > Add Packages...
2. Enter the package repository URL:
   ```
   https://github.com/owdax/SwiftDevKit.git
   ```
3. Select the version you want to use
4. Click Add Package

### Using Package.swift

Add SwiftDevKit as a dependency in your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/owdax/SwiftDevKit.git", from: "1.0.0")
]
```

Then add it to your target's dependencies:

```swift
targets: [
    .target(
        name: "YourTarget",
        dependencies: ["SwiftDevKit"])
]
```

## CocoaPods

> Note: CocoaPods support will be available in future releases.

Add SwiftDevKit to your `Podfile`:

```ruby
pod 'SwiftDevKit'
```

Then run:

```bash
pod install
```

## Verifying Installation

After installation, you should be able to import SwiftDevKit in your code:

```swift
import SwiftDevKit

// Check version
print(SwiftDevKit.version)
```

## Next Steps

- Read the <doc:GettingStarted> guide
- Explore the available utilities
- Check out the API documentation 