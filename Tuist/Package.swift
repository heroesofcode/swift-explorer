// swift-tools-version: 5.9
import PackageDescription

#if TUIST
    import ProjectDescription

    let packageSettings = PackageSettings(productTypes: [:])
#endif

let package = Package(
    name: "SwiftExplorer",
    dependencies: [
        .package(url: "https://github.com/ZeeZide/CodeEditor", exact: "1.2.6"),
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", exact: "1.18.0"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk", exact: "11.7.0"),
        .package(url: "https://github.com/google-gemini/generative-ai-swift", exact: "0.5.6")
    ]
)
