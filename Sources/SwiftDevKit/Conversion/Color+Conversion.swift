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

public extension Color {
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
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        let hex = String(
            format: "%02X%02X%02X",
            Int(red * 255),
            Int(green * 255),
            Int(blue * 255)
        )
        
        return includeHash ? "#\(hex)" : hex
    }
    
    /// Convert RGB color to HSL (Hue, Saturation, Lightness).
    ///
    /// Example:
    /// ```swift
    /// let color = Color.red
    /// let hsl = color.toHSL() // Returns (hue: 0, saturation: 1.0, lightness: 0.5)
    /// ```
    ///
    /// - Returns: Tuple containing hue (0-360), saturation (0-1), and lightness (0-1)
    func toHSL() -> (hue: CGFloat, saturation: CGFloat, lightness: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
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
        
        return (hue: hue, saturation: saturation, lightness: lightness)
    }
    
    /// Initialize a color from HSL values.
    ///
    /// Example:
    /// ```swift
    /// let color = Color(hue: 0, saturation: 1.0, lightness: 0.5) // Red color
    /// ```
    ///
    /// - Parameters:
    ///   - hue: Hue value (0-360)
    ///   - saturation: Saturation value (0-1)
    ///   - lightness: Lightness value (0-1)
    convenience init(hue: CGFloat, saturation: CGFloat, lightness: CGFloat) {
        func hueToRGB(_ p: CGFloat, _ q: CGFloat, _ t: CGFloat) -> CGFloat {
            var t = t
            if t < 0 { t += 1 }
            if t > 1 { t -= 1 }
            if t < 1/6 { return p + (q - p) * 6 * t }
            if t < 1/2 { return q }
            if t < 2/3 { return p + (q - p) * (2/3 - t) * 6 }
            return p
        }
        
        let h = hue / 360
        let q = lightness < 0.5 ?
            lightness * (1 + saturation) :
            lightness + saturation - lightness * saturation
        let p = 2 * lightness - q
        
        let red = hueToRGB(p, q, h + 1/3)
        let green = hueToRGB(p, q, h)
        let blue = hueToRGB(p, q, h - 1/3)
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

#if canImport(UIKit)
public typealias Color = UIColor
#elseif canImport(AppKit)
public typealias Color = NSColor
#endif 