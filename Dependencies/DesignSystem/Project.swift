import ProjectDescription

let project = Project(
    name: "DesignSystem",
    packages: [
        .package(path: "../CommonTest")
    ],
    targets: [
        .target(
            name: "DesignSystem",
            destinations: .macOS,
            product: .staticFramework,
            bundleId: "com.joaolfp.SwiftExplorer.DesignSystem",
            deploymentTargets: .macOS("14.0"),
            sources: ["Sources/DesignSystem/**/*.swift"],
            resources: [
                "Sources/DesignSystem/Resources/**"
            ],
            scripts: [
                .pre(
                    script: """
                    export PATH="$HOME/.local/bin:/opt/homebrew/bin:/usr/local/bin:$PATH"
                    mise exec -- swiftgen config run --config swiftgen.yml
                    """,
                    name: "SwiftGen",
                    inputPaths: ["Sources/DesignSystem/Resources/Fonts/**"],
                    outputPaths: ["Sources/DesignSystem/Generated/FontsFamily.swift"]
                )
            ],
            dependencies: [
                .external(name: "CodeEditor")
            ]
        ),
        .target(
            name: "DesignSystemTests",
            destinations: .macOS,
            product: .unitTests,
            bundleId: "com.joaolfp.SwiftExplorer.DesignSystemTests",
            deploymentTargets: .macOS("14.0"),
            sources: ["Tests/DesignSystemTests/**/*.swift"],
            dependencies: [
                .target(name: "DesignSystem"),
                .package(product: "CommonTest")
            ]
        )
    ]
)
