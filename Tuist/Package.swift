// swift-tools-version: 5.9
import PackageDescription

#if TUIST
    import ProjectDescription

    let packageSettings = PackageSettings(
        // Customize the product types for specific package product
        // Default is .staticFramework
        // productTypes: ["Alamofire": .framework,] 
        productTypes: [:]
    )
#endif

let package = Package(
    name: "SwiftExplorer",
    dependencies: [
        .package(url: "https://github.com/ZeeZide/CodeEditor", exact: "1.2.6"),
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", exact: "1.17.4"),
        .package(path: "../Theme"),
        .package(path: "../Lowlevel"),
        .package(path: "../CommonTest")
    ]
)
