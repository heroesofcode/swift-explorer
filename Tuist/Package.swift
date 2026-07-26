// swift-tools-version: 5.9
import PackageDescription

#if TUIST
import ProjectDescription

let packageSettings = PackageSettings(
    productTypes: [:]
)
#endif

let package = Package(
    name: "SwiftExplorer",
    dependencies: [
        .package(url: "https://github.com/lukepistrol/SwiftLintPlugin", .exact("0.63.1"))
    ]
)
