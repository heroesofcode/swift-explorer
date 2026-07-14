import ProjectDescription

let project = Project(
    name: "Common",
    targets: [
        .target(
            name: "Common",
            destinations: .macOS,
            product: .staticFramework,
            bundleId: "com.joaolfp.SwiftExplorer.Common",
            deploymentTargets: .macOS("14.0"),
            sources: ["Sources/Common/**/*.swift"]
        ),
        .target(
            name: "CommonTests",
            destinations: .macOS,
            product: .unitTests,
            bundleId: "com.joaolfp.SwiftExplorer.CommonTests",
            deploymentTargets: .macOS("14.0"),
            sources: ["Tests/CommonTests/**/*.swift"],
            dependencies: [
                .target(name: "Common")
            ]
        )
    ]
)
