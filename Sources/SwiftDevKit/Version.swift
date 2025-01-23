/// Version information for SwiftDevKit
public enum Version {
    /// The current version of SwiftDevKit
    public static let current = "0.1.0-beta.1"

    /// Build number, automatically incremented by CI
    public static let build = "1"

    /// Whether this is a beta release
    public static let isBeta = true

    /// The minimum supported Swift version
    public static let minimumSwiftVersion = "6.0"

    /// The release date of this version
    public static let releaseDate = "2024-01-21"

    /// Human-readable version string
    public static var versionString: String {
        "\(current) (\(build))"
    }
}
