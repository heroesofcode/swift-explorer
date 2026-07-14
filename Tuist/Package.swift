// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "SwiftExplorer",
    dependencies: [
        .package(url: "https://github.com/joaolfp/CodeEditor", branch: "hotfix/fix-border")
    ]
)
