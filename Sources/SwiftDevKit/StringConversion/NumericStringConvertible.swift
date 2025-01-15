import Foundation

/// Extends numeric types to provide string conversion capabilities.
/// This extension follows the Single Responsibility Principle by focusing solely on numeric string conversion.
extension StringConvertible where Self: Numeric & LosslessStringConvertible {
    public func toString() throws -> String {
        String(describing: self)
    }
    
    public static func fromString(_ string: String) throws -> Self {
        guard let value = Self(string) else {
            throw StringConversionError.invalidInput(string)
        }
        return value
    }
}

// Conformance for basic numeric types
extension Int: StringConvertible {}
extension Double: StringConvertible {}
extension Float: StringConvertible {}
extension Int64: StringConvertible {}
extension UInt: StringConvertible {}
extension UInt64: StringConvertible {} 