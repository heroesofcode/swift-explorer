// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Coordinator",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "Coordinator",
            targets: ["Coordinator"]
        )
    ],
    targets: [
        .target(
            name: "Coordinator"),
        .testTarget(
            name: "CoordinatorTests",
            dependencies: ["Coordinator"]
        )
    ]
)
