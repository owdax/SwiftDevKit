// NumberFormattingTests.swift
// SwiftDevKit
//
// Copyright (c) 2025 owdax and The SwiftDevKit Contributors
// MIT License - https://opensource.org/licenses/MIT

@Test("Test percentage formatting")
func testPercentageFormatting() throws {
    // Basic percentage
    let number = 0.425
    let formatted = try number.asPercentage(decimals: 1)
    #expect(formatted == "42.5%")

    // Zero decimals
    let wholeNumber = try number.asPercentage(decimals: 0)
    #expect(wholeNumber == "43%")

    // Different locale (German)
    let germanLocale = Locale(identifier: "de_DE")
    let germanFormat = try number.asPercentage(decimals: 1, locale: germanLocale)
    #expect(germanFormat == "42,5%")
}

@Test("Test currency formatting")
func testCurrencyFormatting() throws {
    let number = 1234.56

    // US Dollars
    let usd = try number.asCurrency(code: "USD")
    #expect(usd == "$1,234.56")

    // Euros with German locale
    let germanLocale = Locale(identifier: "de_DE")
    let eur = try number.asCurrency(code: "EUR", locale: germanLocale)
    #expect(eur == "1.234,56 €")

    // Japanese Yen (no decimal places)
    let jpy = try number.asCurrency(code: "JPY")
    #expect(jpy == "¥1,235")
}

@Test("Test scientific notation formatting")
func testScientificFormatting() throws {
    let number = 1234.5678

    // Default formatting (2 decimals)
    let formatted = try number.asScientific()
    #expect(formatted == "1.23E3")

    // Custom decimals
    let precise = try number.asScientific(decimals: 4)
    #expect(precise == "1.2346E3")

    // Different locale (German)
    let germanLocale = Locale(identifier: "de_DE")
    let germanFormat = try number.asScientific(locale: germanLocale)
    #expect(germanFormat == "1,23E3")
}

@Test("Test ordinal number formatting")
func testOrdinalFormatting() throws {
    // Basic ordinals
    #expect(try 1.asOrdinal() == "1st")
    #expect(try 2.asOrdinal() == "2nd")
    #expect(try 3.asOrdinal() == "3rd")
    #expect(try 4.asOrdinal() == "4th")
    #expect(try 11.asOrdinal() == "11th")
    #expect(try 21.asOrdinal() == "21st")

    // Different locale (Spanish)
    let spanishLocale = Locale(identifier: "es_ES")
    #expect(try 1.asOrdinal(locale: spanishLocale) == "1.º")
}

@Test("Test number spelling")
func testNumberSpelling() throws {
    let number = 1234

    // Default formatting
    let spelled = try number.asWords()
    #expect(spelled == "one thousand two hundred thirty-four")

    // Capitalized
    let capitalized = try number.asWords(capitalized: true)
    #expect(capitalized == "One thousand two hundred thirty-four")

    // Different locale (French)
    let frenchLocale = Locale(identifier: "fr_FR")
    let frenchSpelling = try number.asWords(locale: frenchLocale)
    #expect(frenchSpelling == "mille deux cent trente-quatre")
}

@Test("Test compact notation")
func testCompactNotation() throws {
    if #available(macOS 11.0, iOS 14.0, watchOS 7.0, tvOS 14.0, *) {
        let number = 1_234_567

        // Default formatting
        let compact = try number.asCompact()
        #expect(compact == "1.2M")

        // Different locale (German)
        let germanLocale = Locale(identifier: "de_DE")
        let germanFormat = try number.asCompact(locale: germanLocale)
        #expect(germanFormat == "1,2 Mio.")
    }
}

@Test("Test binary formatting")
func testBinaryFormatting() throws {
    let number = 42

    // Basic binary
    let binary = try number.asBinary()
    #expect(binary == "101010")

    // With prefix
    let prefixed = try number.asBinary(prefix: true)
    #expect(prefixed == "0b101010")

    // With grouping
    let grouped = try number.asBinary(grouping: true)
    #expect(grouped == "10_1010")

    // With both
    let full = try number.asBinary(prefix: true, grouping: true)
    #expect(full == "0b10_1010")
}

@Test("Test hexadecimal formatting")
func testHexFormatting() throws {
    let number = 255

    // Basic hex
    let hex = try number.asHex()
    #expect(hex == "ff")

    // Uppercase
    let upper = try number.asHex(uppercase: true)
    #expect(upper == "FF")

    // With prefix
    let prefixed = try number.asHex(prefix: true)
    #expect(prefixed == "0xff")

    // With both
    let full = try number.asHex(prefix: true, uppercase: true)
    #expect(full == "0xFF")
}

@Test("Test Roman numeral formatting")
func testRomanFormatting() throws {
    // Basic numbers
    #expect(try 1.asRoman() == "I")
    #expect(try 4.asRoman() == "IV")
    #expect(try 9.asRoman() == "IX")
    #expect(try 49.asRoman() == "XLIX")
    #expect(try 99.asRoman() == "XCIX")
    #expect(try 1994.asRoman() == "MCMXCIV")

    // Lowercase
    #expect(try 1994.asRoman(uppercase: false) == "mcmxciv")

    // Edge cases
    do {
        _ = try 0.asRoman()
        #expect(false, "Should throw for zero")
    } catch {}

    do {
        _ = try 4000.asRoman()
        #expect(false, "Should throw for numbers >= 4000")
    } catch {}

    do {
        _ = try (-1).asRoman()
        #expect(false, "Should throw for negative numbers")
    } catch {}
}

@Test("Test octal formatting")
func testOctalFormatting() throws {
    let number = 342_391

    // Basic octal
    let octal = try number.asOctal()
    #expect(octal == "1234567")

    // With prefix
    let prefixed = try number.asOctal(prefix: true)
    #expect(prefixed == "0o1234567")

    // With grouping
    let grouped = try number.asOctal(grouping: true)
    #expect(grouped == "1_234_567")

    // With both
    let full = try number.asOctal(prefix: true, grouping: true)
    #expect(full == "0o1_234_567")
}

@Test("Test custom base formatting")
func testBaseFormatting() throws {
    let number = 255

    // Base 3
    let base3 = try number.asBase(3)
    #expect(base3 == "100110")

    // Base 36 (lowercase)
    let base36 = try number.asBase(36)
    #expect(base36 == "73")

    // Base 36 (uppercase)
    let base36Upper = try number.asBase(36, uppercase: true)
    #expect(base36Upper == "73")

    // Edge cases
    do {
        _ = try number.asBase(1)
        #expect(false, "Should throw for base < 2")
    } catch {}

    do {
        _ = try number.asBase(37)
        #expect(false, "Should throw for base > 36")
    } catch {}
}

@Test("Test basic decimal formatting")
func testBasicDecimalFormatting() throws {
    let number = 1234.5678

    // Default formatting (2 decimals, with grouping)
    let formatted = try number.formatted()
    #expect(formatted == "1,234.57")

    // Custom decimals
    let precise = try number.formatted(decimals: 4)
    #expect(precise == "1,234.5678")

    // Without grouping
    let ungrouped = try number.formatted(grouping: false)
    #expect(ungrouped == "1234.57")

    // Custom rounding
    let rounded = try number.formatted(decimals: 2, roundingRule: .down)
    #expect(rounded == "1,234.56")
}

@Test("Test accounting format")
func testAccountingFormat() throws {
    // Positive number
    let positive = 1234.56
    let positiveFormat = try positive.asAccounting(code: "USD")
    #expect(positiveFormat == "$1,234.56")

    // Negative number
    let negative = -1234.56
    let negativeFormat = try negative.asAccounting(code: "USD")
    #expect(negativeFormat == "($1,234.56)")

    // With positive symbol
    let withSymbol = try positive.asAccounting(code: "USD", showPositiveSymbol: true)
    #expect(withSymbol == "+$1,234.56")

    // Different locale and currency
    let germanLocale = Locale(identifier: "de_DE")
    let euro = try positive.asAccounting(code: "EUR", locale: germanLocale)
    #expect(euro == "1.234,56 €")

    // Negative with different locale
    let negativeEuro = try negative.asAccounting(code: "EUR", locale: germanLocale)
    #expect(negativeEuro == "(1.234,56 €)")
}

@Test("Test file size formatting")
func testFileSizeFormatting() throws {
    // Basic file size
    let bytes = 1_234_567_890
    let formatted = try bytes.asFileSize()
    #expect(formatted == "1.23 GB")

    // Memory style
    let memory = try bytes.asFileSize(style: .memory)
    #expect(memory == "1.15 GiB")

    // Without unit
    let noUnit = try bytes.asFileSize(includeUnit: false)
    #expect(noUnit == "1.23")

    // Different locale (German)
    let germanLocale = Locale(identifier: "de_DE")
    let germanFormat = try bytes.asFileSize(locale: germanLocale)
    #expect(germanFormat == "1,23 GB")
}

@Test("Test duration formatting")
func testDurationFormatting() throws {
    let seconds = 9045 // 2h 30m 45s

    // Abbreviated style
    let abbreviated = try seconds.asDuration()
    #expect(abbreviated == "2h 30m")

    // Full style
    let full = try seconds.asDuration(style: .full)
    #expect(full == "2 hours, 30 minutes")

    // Different locale (German)
    let germanLocale = Locale(identifier: "de_DE")
    let germanFormat = try seconds.asDuration(style: .full, locale: germanLocale)
    #expect(germanFormat == "2 Stunden, 30 Minuten")
}

@Test("Test fraction formatting")
func testFractionFormatting() throws {
    // Simple fractions
    #expect(try 1.5.asFraction() == "1 1/2")
    #expect(try 0.75.asFraction() == "3/4")
    #expect(try 0.333.asFraction() == "1/3")
    #expect(try 2.0.asFraction() == "2")

    // Custom max denominator
    #expect(try 0.333.asFraction(maxDenominator: 2) == "1/2")
    #expect(try 0.333.asFraction(maxDenominator: 3) == "1/3")

    // Mixed numbers
    #expect(try 2.75.asFraction() == "2 3/4")
}

@Test("Test unit formatting")
func testUnitFormatting() throws {
    if #available(macOS 12.0, iOS 15.0, watchOS 8.0, tvOS 15.0, *) {
        let distance = 5.2

        // Length
        let meters = try distance.asUnit(.meters)
        #expect(meters == "5.2 m")

        let kilometers = try distance.asUnit(.kilometers)
        #expect(kilometers == "5.2 km")

        // Different styles
        let short = try distance.asUnit(.kilometers, style: .short)
        #expect(short == "5.2km")

        let long = try distance.asUnit(.kilometers, style: .long)
        #expect(long == "5.2 kilometers")

        // Different locale (German)
        let germanLocale = Locale(identifier: "de_DE")
        let germanFormat = try distance.asUnit(.kilometers, style: .long, locale: germanLocale)
        #expect(germanFormat == "5,2 Kilometer")
    }
}
