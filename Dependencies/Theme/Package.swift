// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Theme",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "Theme",
            targets: ["Theme"]
        )
    ],
    targets: [
        .target(
            name: "Theme",
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "ThemeTests",
            dependencies: ["Theme"]
        )
    ]
)
