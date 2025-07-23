// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CommonTest",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "CommonTest",
            targets: ["CommonTest"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/pointfreeco/swift-snapshot-testing",
            exact: "1.18.6"
        )
    ],
    targets: [
        .target(
            name: "CommonTest",
            dependencies: [
                .product(
                    name: "SnapshotTesting",
                    package: "swift-snapshot-testing"
                )
            ]
        )
    ]
)
