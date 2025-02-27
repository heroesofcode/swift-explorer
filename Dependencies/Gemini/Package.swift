// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Gemini",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "Gemini",
            targets: ["Gemini"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/google-gemini/generative-ai-swift", exact: "0.5.6")
    ],
    targets: [
        .target(
            name: "Gemini",
            dependencies: [
                .product(name: "GoogleGenerativeAI", package: "generative-ai-swift")
            ]
        ),
        .testTarget(
            name: "GeminiTests",
            dependencies: ["Gemini"]
        )
    ]
)
