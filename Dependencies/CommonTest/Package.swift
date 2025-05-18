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
    targets: [
        .target(
            name: "CommonTest"
        )
    ]
)
