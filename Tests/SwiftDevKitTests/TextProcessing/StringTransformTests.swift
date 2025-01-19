// StringTransformTests.swift
// SwiftDevKit
//
// Copyright (c) 2025 owdax and The SwiftDevKit Contributors
// MIT License - https://opensource.org/licenses/MIT

import Foundation
import Testing
@testable import SwiftDevKit

@Suite("String Transform Tests")
struct StringTransformTests {
    @Test("Test title case transformation")
    func testTitleCase() throws {
        // Basic title case
        #expect(try "hello world".toTitleCase() == "Hello World")
        #expect(try "HELLO WORLD".toTitleCase() == "Hello World")
        #expect(try "hello WORLD".toTitleCase() == "Hello World")
        
        // Edge cases
        #expect(try "".toTitleCase() == "")
        #expect(try "hello".toTitleCase() == "Hello")
        #expect(try "   ".toTitleCase() == "   ")
    }
    
    @Test("Test camel case transformation")
    func testCamelCase() throws {
        // Basic camel case
        #expect(try "hello world".toCamelCase() == "helloWorld")
        #expect(try "Hello World".toCamelCase() == "helloWorld")
        #expect(try "HELLO WORLD".toCamelCase() == "helloWorld")
        
        // With special characters
        #expect(try "hello-world".toCamelCase() == "helloWorld")
        #expect(try "hello_world".toCamelCase() == "helloWorld")
        #expect(try "hello.world".toCamelCase() == "helloWorld")
        
        // Edge cases
        #expect(try "".toCamelCase() == "")
        #expect(try "hello".toCamelCase() == "hello")
        #expect(try "   ".toCamelCase() == "   ")
    }
    
    @Test("Test snake case transformation")
    func testSnakeCase() throws {
        // Basic snake case
        #expect(try "hello world".toSnakeCase() == "hello_world")
        #expect(try "helloWorld".toSnakeCase() == "hello_world")
        #expect(try "HelloWorld".toSnakeCase() == "hello_world")
        
        // With special characters
        #expect(try "hello-world".toSnakeCase() == "hello_world")
        #expect(try "hello.world".toSnakeCase() == "hello_world")
        #expect(try "hello   world".toSnakeCase() == "hello_world")
        
        // Complex cases
        #expect(try "ThisIsALongVariableName".toSnakeCase() == "this_is_a_long_variable_name")
        #expect(try "ABC".toSnakeCase() == "a_b_c")
        #expect(try "IOSDevice".toSnakeCase() == "ios_device")
        
        // Edge cases
        #expect(try "".toSnakeCase() == "")
        #expect(try "hello".toSnakeCase() == "hello")
        #expect(try "   ".toSnakeCase() == "   ")
    }
    
    @Test("Test kebab case transformation")
    func testKebabCase() throws {
        // Basic kebab case
        #expect(try "hello world".toKebabCase() == "hello-world")
        #expect(try "helloWorld".toKebabCase() == "hello-world")
        #expect(try "HelloWorld".toKebabCase() == "hello-world")
        
        // With special characters
        #expect(try "hello_world".toKebabCase() == "hello-world")
        #expect(try "hello.world".toKebabCase() == "hello-world")
        #expect(try "hello   world".toKebabCase() == "hello-world")
        
        // Complex cases
        #expect(try "ThisIsALongVariableName".toKebabCase() == "this-is-a-long-variable-name")
        #expect(try "ABC".toKebabCase() == "a-b-c")
        #expect(try "IOSDevice".toKebabCase() == "ios-device")
        
        // Edge cases
        #expect(try "".toKebabCase() == "")
        #expect(try "hello".toKebabCase() == "hello")
        #expect(try "   ".toKebabCase() == "   ")
    }
    
    @Test("Test excess whitespace removal")
    func testRemoveExcessWhitespace() throws {
        // Basic whitespace removal
        #expect(try "hello   world".removeExcessWhitespace() == "hello world")
        #expect(try "   hello   world   ".removeExcessWhitespace() == "hello world")
        #expect(try "hello\nworld".removeExcessWhitespace() == "hello world")
        #expect(try "hello\tworld".removeExcessWhitespace() == "hello world")
        
        // Multiple types of whitespace
        #expect(try "hello\n  \t  world".removeExcessWhitespace() == "hello world")
        
        // Edge cases
        #expect(try "".removeExcessWhitespace() == "")
        #expect(try "hello".removeExcessWhitespace() == "hello")
        #expect(try "   ".removeExcessWhitespace() == "")
    }
    
    @Test("Test string truncation")
    func testTruncate() throws {
        let text = "This is a long text that needs to be truncated"
        
        // Basic truncation
        #expect(try text.truncate(length: 10) == "This i...")
        #expect(try text.truncate(length: 20) == "This is a long t...")
        
        // Non-smart truncation
        #expect(try text.truncate(length: 10, smart: false) == "This i...")
        #expect(try text.truncate(length: 20, smart: false) == "This is a long t...")
        
        // Custom ellipsis
        #expect(try text.truncate(length: 10, ellipsis: "…") == "This is…")
        #expect(try text.truncate(length: 10, ellipsis: "") == "This is a")
        
        // Edge cases
        #expect(throws: StringTransformError.invalidInput("Length must be greater than 0")) {
            try text.truncate(length: 0)
        }
        
        #expect(try "Short".truncate(length: 10) == "Short")
        #expect(try "".truncate(length: 10) == "")
    }
} 
