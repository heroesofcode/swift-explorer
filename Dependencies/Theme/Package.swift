// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Theme",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "Theme",
            targets: ["Theme"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/ZeeZide/CodeEditor",
            exact: "1.2.6"
        )
    ],
    targets: [
        .target(
            name: "Theme",
            dependencies: [
                "CodeEditor"
            ],
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
