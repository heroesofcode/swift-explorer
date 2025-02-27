// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Lowlevel",
    defaultLocalization: "en",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "Lowlevel",
            targets: ["Lowlevel"]
        )
    ],
    targets: [
        .target(
            name: "Lowlevel",
            resources: [
                .process("Localizable")
            ]
        ),
        .testTarget(
            name: "LowlevelTests",
            dependencies: ["Lowlevel"]
        )
    ]
)
