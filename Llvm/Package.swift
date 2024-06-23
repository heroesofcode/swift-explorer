// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Llvm",
    defaultLocalization: "en",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "Llvm",
            targets: ["Llvm"]
        )
    ],
    targets: [
        .target(
            name: "Llvm",
            resources: [
                .process("Localizable")
            ]
        ),
        .testTarget(
            name: "LlvmTests",
            dependencies: ["Llvm"]
        )
    ]
)
