// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-random",
    platforms: [
        .macOS(.v13),
        .iOS(.v13),
        .watchOS(.v6),
        .tvOS(.v13),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Random",
            targets: ["Random"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-crypto.git", from: "3.12.5"),
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.6.1"),
        .package(url: "https://github.com/vitali-kurlovich/Benchmarks", from: "0.1.1"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Random",
            dependencies: [
                .product(name: "Crypto", package: "swift-crypto"),
            ]
        ),
        .executableTarget(
            name: "RandomGeneratorBenchmarks",

            dependencies: [
                "Random",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "Benchmarks",
            ],
            path: "Sources/Benchmarks"
        ),
        .testTarget(
            name: "RandomTests",
            dependencies: [
                "Random",
            ]
        ),
    ]
)
