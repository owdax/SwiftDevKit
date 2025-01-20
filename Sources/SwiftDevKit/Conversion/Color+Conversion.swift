// Color+Conversion.swift
// SwiftDevKit
//
// Copyright (c) 2025 owdax and The SwiftDevKit Contributors
// MIT License - https://opensource.org/licenses/MIT

import Foundation
#if canImport(UIKit)
    import UIKit
#elseif canImport(AppKit)
    import AppKit
#endif

/// Represents HSL (Hue, Saturation, Lightness) color values
public struct HSL {
    /// Hue value (0-360)
    public let hue: CGFloat
    /// Saturation value (0-1)
    public let saturation: CGFloat
    /// Lightness value (0-1)
    public let lightness: CGFloat
}

/// Represents HSV (Hue, Saturation, Value) color values
public struct HSV {
    /// Hue value (0-360)
    public let hue: CGFloat
    /// Saturation value (0-1)
    public let saturation: CGFloat
    /// Value/Brightness value (0-1)
    public let value: CGFloat
}

/// Represents CMYK (Cyan, Magenta, Yellow, Key/Black) color values
public struct CMYK {
    /// Cyan value (0-1)
    public let cyan: CGFloat
    /// Magenta value (0-1)
    public let magenta: CGFloat
    /// Yellow value (0-1)
    public let yellow: CGFloat
    /// Key/Black value (0-1)
    public let key: CGFloat
}

/// Represents RGB (Red, Green, Blue) color values with alpha
public struct RGB {
    /// Red value (0-1)
    public let red: CGFloat
    /// Green value (0-1)
    public let green: CGFloat
    /// Blue value (0-1)
    public let blue: CGFloat
    /// Alpha value (0-1)
    public let alpha: CGFloat
}

public extension Color {
    /// Helper method to get RGB components with color space conversion if needed
    private func rgbComponents() -> RGB {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        #if canImport(AppKit)
            guard let rgbColor = usingColorSpace(.sRGB) else {
                return RGB(red: 0, green: 0, blue: 0, alpha: 1)
            }
            rgbColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        #else
            getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        #endif

        return RGB(red: red, green: green, blue: blue, alpha: alpha)
    }

    /// Initialize a color from a hex string.
    ///
    /// Example:
    /// ```swift
    /// let color = Color(hex: "#FF0000") // Red color
    /// let colorWithoutHash = Color(hex: "00FF00") // Green color
    /// ```
    ///
    /// - Parameter hex: A hex string in format "#RRGGBB" or "RRGGBB"
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        guard hexSanitized.count == 6 else { return nil }

        var rgb: UInt64 = 0
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }

    /// Convert color to hex string.
    ///
    /// Example:
    /// ```swift
    /// let color = Color.red
    /// let hex = color.toHex() // Returns "#FF0000"
    /// ```
    ///
    /// - Parameter includeHash: Whether to include # prefix (default: true)
    /// - Returns: Hex string representation of the color
    func toHex(includeHash: Bool = true) -> String {
        let components = rgbComponents()
        let hex = String(
            format: "%02X%02X%02X",
            Int(components.red * 255),
            Int(components.green * 255),
            Int(components.blue * 255))

        return includeHash ? "#\(hex)" : hex
    }

    /// Convert RGB color to HSL (Hue, Saturation, Lightness).
    ///
    /// Example:
    /// ```swift
    /// let color = Color.red
    /// let hsl = color.toHSL() // Returns HSL(hue: 0, saturation: 1.0, lightness: 0.5)
    /// ```
    ///
    /// - Returns: HSL color values
    func toHSL() -> HSL {
        let components = rgbComponents()
        let red = components.red
        let green = components.green
        let blue = components.blue

        let maximum = max(red, green, blue)
        let minimum = min(red, green, blue)

        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        let lightness = (maximum + minimum) / 2

        let delta = maximum - minimum

        if delta != 0 {
            saturation = lightness > 0.5 ?
                delta / (2 - maximum - minimum) :
                delta / (maximum + minimum)

            switch maximum {
                case red:
                    hue = (green - blue) / delta + (green < blue ? 6 : 0)
                case green:
                    hue = (blue - red) / delta + 2
                default:
                    hue = (red - green) / delta + 4
            }

            hue *= 60
        }

        return HSL(hue: hue, saturation: saturation, lightness: lightness)
    }

    /// Initialize a color from HSL values.
    ///
    /// Example:
    /// ```swift
    /// let color = Color(hsl: HSL(hue: 0, saturation: 1.0, lightness: 0.5)) // Red color
    /// ```
    ///
    /// - Parameter hsl: HSL color values
    convenience init(hsl: HSL) {
        func hueToRGB(_ primary: CGFloat, _ secondary: CGFloat, _ third: CGFloat) -> CGFloat {
            var hueComponent = third
            if hueComponent < 0 { hueComponent += 1 }
            if hueComponent > 1 { hueComponent -= 1 }
            if hueComponent < 1 / 6 { return primary + (secondary - primary) * 6 * hueComponent }
            if hueComponent < 1 / 2 { return secondary }
            if hueComponent < 2 / 3 { return primary + (secondary - primary) * (2 / 3 - hueComponent) * 6 }
            return primary
        }

        let normalizedHue = hsl.hue / 360
        let secondaryComponent = hsl.lightness < 0.5 ?
            hsl.lightness * (1 + hsl.saturation) :
            hsl.lightness + hsl.saturation - hsl.lightness * hsl.saturation
        let primaryComponent = 2 * hsl.lightness - secondaryComponent

        let red = hueToRGB(primaryComponent, secondaryComponent, normalizedHue + 1 / 3)
        let green = hueToRGB(primaryComponent, secondaryComponent, normalizedHue)
        let blue = hueToRGB(primaryComponent, secondaryComponent, normalizedHue - 1 / 3)

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }

    /// Convert RGB color to CMYK (Cyan, Magenta, Yellow, Key/Black).
    ///
    /// Example:
    /// ```swift
    /// let color = Color.red
    /// let cmyk = color.toCMYK() // Returns CMYK(cyan: 0, magenta: 1.0, yellow: 1.0, key: 0)
    /// ```
    ///
    /// - Returns: CMYK color values
    func toCMYK() -> CMYK {
        let components = rgbComponents()
        let red = components.red
        let green = components.green
        let blue = components.blue

        let key = 1 - max(red, green, blue)
        guard key != 1 else { return CMYK(cyan: 0, magenta: 0, yellow: 0, key: 1) }

        let cyan = (1 - red - key) / (1 - key)
        let magenta = (1 - green - key) / (1 - key)
        let yellow = (1 - blue - key) / (1 - key)

        return CMYK(cyan: cyan, magenta: magenta, yellow: yellow, key: key)
    }

    /// Initialize a color from CMYK values.
    ///
    /// Example:
    /// ```swift
    /// let color = Color(cmyk: CMYK(cyan: 0, magenta: 1.0, yellow: 1.0, key: 0)) // Red color
    /// ```
    ///
    /// - Parameter cmyk: CMYK color values
    convenience init(cmyk: CMYK) {
        let red = (1 - cmyk.cyan) * (1 - cmyk.key)
        let green = (1 - cmyk.magenta) * (1 - cmyk.key)
        let blue = (1 - cmyk.yellow) * (1 - cmyk.key)

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }

    /// Convert RGB color to HSV (Hue, Saturation, Value).
    ///
    /// Example:
    /// ```swift
    /// let color = Color.red
    /// let hsv = color.toHSV() // Returns HSV(hue: 0, saturation: 1.0, value: 1.0)
    /// ```
    ///
    /// - Returns: HSV color values
    func toHSV() -> HSV {
        let components = rgbComponents()
        let red = components.red
        let green = components.green
        let blue = components.blue

        let maximum = max(red, green, blue)
        let minimum = min(red, green, blue)
        let delta = maximum - minimum

        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        let value = maximum

        if delta != 0 {
            saturation = delta / maximum

            switch maximum {
                case red:
                    hue = (green - blue) / delta + (green < blue ? 6 : 0)
                case green:
                    hue = (blue - red) / delta + 2
                default:
                    hue = (red - green) / delta + 4
            }

            hue *= 60
        }

        return HSV(hue: hue, saturation: saturation, value: value)
    }

    /// Initialize a color from HSV values.
    ///
    /// Example:
    /// ```swift
    /// let color = Color(hsv: HSV(hue: 0, saturation: 1.0, value: 1.0)) // Red color
    /// ```
    ///
    /// - Parameter hsv: HSV color values
    convenience init(hsv: HSV) {
        let normalizedHue = hsv.hue / 60
        let integerPart = floor(normalizedHue)
        let fractionalPart = normalizedHue - integerPart

        let minValue = hsv.value * (1 - hsv.saturation)
        let decreasing = hsv.value * (1 - hsv.saturation * fractionalPart)
        let increasing = hsv.value * (1 - hsv.saturation * (1 - fractionalPart))

        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0

        switch Int(integerPart) % 6 {
            case 0:
                red = hsv.value
                green = increasing
                blue = minValue
            case 1:
                red = decreasing
                green = hsv.value
                blue = minValue
            case 2:
                red = minValue
                green = hsv.value
                blue = increasing
            case 3:
                red = minValue
                green = decreasing
                blue = hsv.value
            case 4:
                red = increasing
                green = minValue
                blue = hsv.value
            default:
                red = hsv.value
                green = minValue
                blue = decreasing
        }

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

#if canImport(UIKit)
    public typealias Color = UIColor
#elseif canImport(AppKit)
    public typealias Color = NSColor
#endif
