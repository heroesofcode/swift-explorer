// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Bytecode",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "Bytecode",
            targets: ["Bytecode"]),
    ],
    targets: [
        .target(
            name: "Bytecode"),
        .testTarget(
            name: "BytecodeTests",
            dependencies: ["Bytecode"]),
    ]
)
