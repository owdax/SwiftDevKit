# Color Conversion Utilities

SwiftDevKit provides a comprehensive set of color conversion utilities that work seamlessly across iOS and macOS platforms. These utilities enable easy conversion between different color spaces and formats commonly used in digital design and development.

## Supported Color Spaces

- RGB (Red, Green, Blue)
- HSL (Hue, Saturation, Lightness)
- HSV (Hue, Saturation, Value)
- CMYK (Cyan, Magenta, Yellow, Key/Black)
- Hex string representation

## Value Ranges

All color components are normalized to use consistent value ranges:

- RGB components (red, green, blue): 0 to 1
- HSL/HSV hue: 0 to 360 degrees
- HSL/HSV saturation: 0 to 1
- HSL lightness: 0 to 1
- HSV value: 0 to 1
- CMYK components: 0 to 1
- Alpha: 0 to 1

## Usage Examples

### Creating Colors

```swift
// From hex string
let redFromHex = Color(hex: "#FF0000")
let blueFromHex = Color(hex: "0000FF") // # is optional

// From HSL
let greenFromHSL = Color(hsl: HSL(
    hue: 120,        // Green hue (120 degrees)
    saturation: 1.0, // Full saturation
    lightness: 0.5   // Medium lightness
))

// From HSV
let blueFromHSV = Color(hsv: HSV(
    hue: 240,        // Blue hue (240 degrees)
    saturation: 1.0, // Full saturation
    value: 1.0       // Maximum brightness
))

// From CMYK
let yellowFromCMYK = Color(cmyk: CMYK(
    cyan: 0,    // No cyan
    magenta: 0, // No magenta
    yellow: 1.0, // Full yellow
    key: 0      // No black
))
```

### Converting Colors

```swift
let color = Color.red

// To hex string
let hex = color.toHex()           // "#FF0000"
let hexNoHash = color.toHex(includeHash: false) // "FF0000"

// To HSL
let hsl = color.toHSL()
// HSL(hue: 0, saturation: 1.0, lightness: 0.5)

// To HSV
let hsv = color.toHSV()
// HSV(hue: 0, saturation: 1.0, value: 1.0)

// To CMYK
let cmyk = color.toCMYK()
// CMYK(cyan: 0, magenta: 1.0, yellow: 1.0, key: 0)
```

## Color Models

### RGB Structure
```swift
public struct RGB {
    public let red: CGFloat    // 0-1
    public let green: CGFloat  // 0-1
    public let blue: CGFloat   // 0-1
    public let alpha: CGFloat  // 0-1
}
```

### HSL Structure
```swift
public struct HSL {
    public let hue: CGFloat        // 0-360
    public let saturation: CGFloat // 0-1
    public let lightness: CGFloat  // 0-1
}
```

### HSV Structure
```swift
public struct HSV {
    public let hue: CGFloat        // 0-360
    public let saturation: CGFloat // 0-1
    public let value: CGFloat      // 0-1
}
```

### CMYK Structure
```swift
public struct CMYK {
    public let cyan: CGFloat    // 0-1
    public let magenta: CGFloat // 0-1
    public let yellow: CGFloat  // 0-1
    public let key: CGFloat     // 0-1
}
```

## Platform Compatibility

The color conversion utilities work consistently across both iOS and macOS platforms:

- iOS: Uses `UIColor` as the base color type
- macOS: Uses `NSColor` as the base color type

The code automatically handles the appropriate color type through a type alias:

```swift
#if canImport(UIKit)
    public typealias Color = UIColor
#elseif canImport(AppKit)
    public typealias Color = NSColor
#endif
```

## Error Handling

- Hex string initialization returns an optional and fails gracefully if the string format is invalid
- Color space conversions handle edge cases and provide reasonable defaults
- Platform-specific color space conversions are handled automatically

## Best Practices

1. Always check if hex string initialization succeeded before using the color
2. Use the appropriate color space for your specific needs:
   - HSL: When you need intuitive control over lightness
   - HSV: When you need intuitive control over brightness/value
   - CMYK: When working with print-related colors
   - RGB/Hex: When working with web colors or digital displays
3. Consider color space conversion implications when targeting both iOS and macOS 