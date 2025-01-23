// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftDevKit",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
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
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SwiftDevKit",
            dependencies: [],
            resources: [.process("Resources")],
            swiftSettings: [
                .define("SWIFT_STRICT_CONCURRENCY", .when(configuration: .debug)),
            ]),
        .testTarget(
            name: "SwiftDevKitTests",
            dependencies: ["SwiftDevKit"],
            swiftSettings: [
                .define("SWIFT_STRICT_CONCURRENCY", .when(configuration: .debug)),
            ]),
    ])
