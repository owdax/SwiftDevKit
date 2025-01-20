// ColorConversionTests.swift
// SwiftDevKit
//
// Copyright (c) 2025 owdax and The SwiftDevKit Contributors
// MIT License - https://opensource.org/licenses/MIT

import XCTest
@testable import SwiftDevKit

final class ColorConversionTests: XCTestCase {
    func testHexInitialization() {
        // Test with hash prefix
        let redColor = Color(hex: "#FF0000")
        XCTAssertNotNil(redColor)

        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        redColor?.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        XCTAssertEqual(red, 1.0, accuracy: 0.01)
        XCTAssertEqual(green, 0.0, accuracy: 0.01)
        XCTAssertEqual(blue, 0.0, accuracy: 0.01)
        XCTAssertEqual(alpha, 1.0, accuracy: 0.01)

        // Test without hash prefix
        let greenColor = Color(hex: "00FF00")
        XCTAssertNotNil(greenColor)

        greenColor?.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        XCTAssertEqual(red, 0.0, accuracy: 0.01)
        XCTAssertEqual(green, 1.0, accuracy: 0.01)
        XCTAssertEqual(blue, 0.0, accuracy: 0.01)
        XCTAssertEqual(alpha, 1.0, accuracy: 0.01)

        // Test invalid hex strings
        XCTAssertNil(Color(hex: "Invalid"))
        XCTAssertNil(Color(hex: "FF00"))
        XCTAssertNil(Color(hex: "#FF00"))
    }

    func testToHex() {
        let redColor = Color.red
        XCTAssertEqual(redColor.toHex(), "#FF0000")
        XCTAssertEqual(redColor.toHex(includeHash: false), "FF0000")

        let greenColor = Color.green
        XCTAssertEqual(greenColor.toHex(), "#00FF00")
        XCTAssertEqual(greenColor.toHex(includeHash: false), "00FF00")

        let blueColor = Color.blue
        XCTAssertEqual(blueColor.toHex(), "#0000FF")
        XCTAssertEqual(blueColor.toHex(includeHash: false), "0000FF")
    }

    func testHSLConversion() {
        // Test red color HSL values
        let redColor = Color.red
        let redHSL = redColor.toHSL()
        XCTAssertEqual(redHSL.hue, 0.0, accuracy: 0.01)
        XCTAssertEqual(redHSL.saturation, 1.0, accuracy: 0.01)
        XCTAssertEqual(redHSL.lightness, 0.5, accuracy: 0.01)

        // Test green color HSL values
        let greenColor = Color.green
        let greenHSL = greenColor.toHSL()
        XCTAssertEqual(greenHSL.hue, 120.0, accuracy: 0.01)
        XCTAssertEqual(greenHSL.saturation, 1.0, accuracy: 0.01)
        XCTAssertEqual(greenHSL.lightness, 0.5, accuracy: 0.01)

        // Test blue color HSL values
        let blueColor = Color.blue
        let blueHSL = blueColor.toHSL()
        XCTAssertEqual(blueHSL.hue, 240.0, accuracy: 0.01)
        XCTAssertEqual(blueHSL.saturation, 1.0, accuracy: 0.01)
        XCTAssertEqual(blueHSL.lightness, 0.5, accuracy: 0.01)
    }

    func testHSLInitialization() {
        // Test creating red color from HSL
        let redColor = Color(hsl: HSL(hue: 0, saturation: 1.0, lightness: 0.5))
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        redColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        XCTAssertEqual(red, 1.0, accuracy: 0.01)
        XCTAssertEqual(green, 0.0, accuracy: 0.01)
        XCTAssertEqual(blue, 0.0, accuracy: 0.01)

        // Test creating green color from HSL
        let greenColor = Color(hsl: HSL(hue: 120, saturation: 1.0, lightness: 0.5))
        greenColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        XCTAssertEqual(red, 0.0, accuracy: 0.01)
        XCTAssertEqual(green, 1.0, accuracy: 0.01)
        XCTAssertEqual(blue, 0.0, accuracy: 0.01)

        // Test creating blue color from HSL
        let blueColor = Color(hsl: HSL(hue: 240, saturation: 1.0, lightness: 0.5))
        blueColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        XCTAssertEqual(red, 0.0, accuracy: 0.01)
        XCTAssertEqual(green, 0.0, accuracy: 0.01)
        XCTAssertEqual(blue, 1.0, accuracy: 0.01)
    }

    func testCMYKConversion() {
        // Test red color CMYK values
        let redColor = Color.red
        let redCMYK = redColor.toCMYK()
        XCTAssertEqual(redCMYK.cyan, 0.0, accuracy: 0.01)
        XCTAssertEqual(redCMYK.magenta, 1.0, accuracy: 0.01)
        XCTAssertEqual(redCMYK.yellow, 1.0, accuracy: 0.01)
        XCTAssertEqual(redCMYK.key, 0.0, accuracy: 0.01)

        // Test green color CMYK values
        let greenColor = Color.green
        let greenCMYK = greenColor.toCMYK()
        XCTAssertEqual(greenCMYK.cyan, 1.0, accuracy: 0.01)
        XCTAssertEqual(greenCMYK.magenta, 0.0, accuracy: 0.01)
        XCTAssertEqual(greenCMYK.yellow, 1.0, accuracy: 0.01)
        XCTAssertEqual(greenCMYK.key, 0.0, accuracy: 0.01)

        // Test blue color CMYK values
        let blueColor = Color.blue
        let blueCMYK = blueColor.toCMYK()
        XCTAssertEqual(blueCMYK.cyan, 1.0, accuracy: 0.01)
        XCTAssertEqual(blueCMYK.magenta, 1.0, accuracy: 0.01)
        XCTAssertEqual(blueCMYK.yellow, 0.0, accuracy: 0.01)
        XCTAssertEqual(blueCMYK.key, 0.0, accuracy: 0.01)

        // Test black color CMYK values
        let blackColor = Color.black
        let blackCMYK = blackColor.toCMYK()
        XCTAssertEqual(blackCMYK.cyan, 0.0, accuracy: 0.01)
        XCTAssertEqual(blackCMYK.magenta, 0.0, accuracy: 0.01)
        XCTAssertEqual(blackCMYK.yellow, 0.0, accuracy: 0.01)
        XCTAssertEqual(blackCMYK.key, 1.0, accuracy: 0.01)
    }

    func testCMYKInitialization() {
        // Test creating red color from CMYK
        let redColor = Color(cmyk: CMYK(cyan: 0, magenta: 1.0, yellow: 1.0, key: 0))
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        redColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        XCTAssertEqual(red, 1.0, accuracy: 0.01)
        XCTAssertEqual(green, 0.0, accuracy: 0.01)
        XCTAssertEqual(blue, 0.0, accuracy: 0.01)

        // Test creating green color from CMYK
        let greenColor = Color(cmyk: CMYK(cyan: 1.0, magenta: 0, yellow: 1.0, key: 0))
        greenColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        XCTAssertEqual(red, 0.0, accuracy: 0.01)
        XCTAssertEqual(green, 1.0, accuracy: 0.01)
        XCTAssertEqual(blue, 0.0, accuracy: 0.01)

        // Test creating blue color from CMYK
        let blueColor = Color(cmyk: CMYK(cyan: 1.0, magenta: 1.0, yellow: 0, key: 0))
        blueColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        XCTAssertEqual(red, 0.0, accuracy: 0.01)
        XCTAssertEqual(green, 0.0, accuracy: 0.01)
        XCTAssertEqual(blue, 1.0, accuracy: 0.01)
    }

    func testHSVConversion() {
        // Test red color HSV values
        let redColor = Color.red
        let redHSV = redColor.toHSV()
        XCTAssertEqual(redHSV.hue, 0.0, accuracy: 0.01)
        XCTAssertEqual(redHSV.saturation, 1.0, accuracy: 0.01)
        XCTAssertEqual(redHSV.value, 1.0, accuracy: 0.01)

        // Test green color HSV values
        let greenColor = Color.green
        let greenHSV = greenColor.toHSV()
        XCTAssertEqual(greenHSV.hue, 120.0, accuracy: 0.01)
        XCTAssertEqual(greenHSV.saturation, 1.0, accuracy: 0.01)
        XCTAssertEqual(greenHSV.value, 1.0, accuracy: 0.01)

        // Test blue color HSV values
        let blueColor = Color.blue
        let blueHSV = blueColor.toHSV()
        XCTAssertEqual(blueHSV.hue, 240.0, accuracy: 0.01)
        XCTAssertEqual(blueHSV.saturation, 1.0, accuracy: 0.01)
        XCTAssertEqual(blueHSV.value, 1.0, accuracy: 0.01)
    }

    func testHSVInitialization() {
        // Test creating red color from HSV
        let redColor = Color(hsv: HSV(hue: 0, saturation: 1.0, value: 1.0))
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        redColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        XCTAssertEqual(red, 1.0, accuracy: 0.01)
        XCTAssertEqual(green, 0.0, accuracy: 0.01)
        XCTAssertEqual(blue, 0.0, accuracy: 0.01)

        // Test creating green color from HSV
        let greenColor = Color(hsv: HSV(hue: 120, saturation: 1.0, value: 1.0))
        greenColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        XCTAssertEqual(red, 0.0, accuracy: 0.01)
        XCTAssertEqual(green, 1.0, accuracy: 0.01)
        XCTAssertEqual(blue, 0.0, accuracy: 0.01)

        // Test creating blue color from HSV
        let blueColor = Color(hsv: HSV(hue: 240, saturation: 1.0, value: 1.0))
        blueColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        XCTAssertEqual(red, 0.0, accuracy: 0.01)
        XCTAssertEqual(green, 0.0, accuracy: 0.01)
        XCTAssertEqual(blue, 1.0, accuracy: 0.01)
    }
}
