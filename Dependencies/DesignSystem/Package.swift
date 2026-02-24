// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let githubUrl = "https://github.com/"

let package = Package(
    name: "DesignSystem",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "DesignSystem",
            targets: ["DesignSystem"]
        )
    ],
    dependencies: [
        .package(url: "\(githubUrl)joaolfp/CodeEditor", branch: "hotfix/fix-border"),
        .package(url: "\(githubUrl)SwiftGen/SwiftGenPlugin", from: "6.6.2"),
        .package(path: "../CommonTest")
    ],
    targets: [
        .target(
            name: "DesignSystem",
            dependencies: [
                "CodeEditor"
            ],
            resources: [
                .process("Resources")
            ],
            plugins: [
                .plugin(name: "SwiftGenPlugin", package: "SwiftGenPlugin")
            ]
        ),
        .testTarget(
            name: "DesignSystemTests",
            dependencies: [
                "DesignSystem",
                "CommonTest"
            ]
        )
    ]
)
