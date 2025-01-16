// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftDevKit",
    defaultLocalization: nil,
    platforms: [
        .macOS(.v13),
        .iOS(.v16),
        .tvOS(.v16),
        .watchOS(.v9),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SwiftDevKit",
            targets: ["SwiftDevKit"]),
    ],
    dependencies: [
        // Dependencies will be added as needed
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SwiftDevKit",
            path: "Sources/SwiftDevKit",
            exclude: [
                "Documentation.docc/Installation.md",
                "Documentation.docc/Architecture.md",
                "Documentation.docc/Contributing.md",
                "Documentation.docc/Conversion.md",
                "Documentation.docc/GettingStarted.md",
                "Documentation.docc/SwiftDevKit.md",
            ],
            resources: [
                .copy("Resources"),
            ],
            swiftSettings: [
                .define("SWIFT_STRICT_CONCURRENCY", .when(configuration: .debug)),
            ]),
        .testTarget(
            name: "SwiftDevKitTests",
            dependencies: [
                "SwiftDevKit",
            ],
            swiftSettings: [
                .define("SWIFT_STRICT_CONCURRENCY", .when(configuration: .debug)),
            ]),
    ])
