// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftDevKit",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SwiftDevKit",
            targets: ["SwiftDevKit"]),
    ],
    dependencies: [
        // Dependencies will be added as needed
        .package(url: "https://github.com/apple/swift-testing.git", from: "0.5.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SwiftDevKit",
            dependencies: [],
            swiftSettings: [
                .define("DEBUG", .when(configuration: .debug)),
                .enableUpcomingFeature("BareSlashRegexLiterals"),
                .enableExperimentalFeature("StrictConcurrency"),
            ]),
        .testTarget(
            name: "SwiftDevKitTests",
            dependencies: [
                "SwiftDevKit",
                .product(name: "Testing", package: "swift-testing"),
            ]),
    ])
