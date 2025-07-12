// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Common",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "Common",
            targets: ["Common"]
        )
    ],
    targets: [
        .target(
            name: "Common"
        ),
        .testTarget(
            name: "CommonTests",
            dependencies: ["Common"]
        )
    ]
)
