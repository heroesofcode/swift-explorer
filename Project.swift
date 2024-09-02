import ProjectDescription

let project = Project(
    name: "SwiftExplorer",
    targets: [
        .target(
            name: "SwiftExplorer",
            destinations: .macOS,
            product: .app,
            bundleId: "com.joaolfp.SwiftExplorer",
            deploymentTargets: .macOS("14.0"),
            infoPlist: .extendingDefault(with: [
                "CFBundleShortVersionString": "1.5.0",
                "CFBundleVersion": "1"
            ]),
            sources: ["SwiftExplorer/**"],
            resources: [
                "SwiftExplorer/Assets.xcassets",
                "SwiftExplorer/Localizable/en.lproj/**",
                "SwiftExplorer/Preview Content/**"
            ],
            dependencies: [
                .external(name: "CodeEditor"),
                .external(name: "Theme"),
                .external(name: "Lowlevel")
            ]
        ),
        .target(
            name: "SwiftExplorerTests",
            destinations: .macOS,
            product: .unitTests,
            bundleId: "com.joaolfp.SwiftExplorerTests",
            sources: ["SwiftExplorerTests/**"],
            resources: [],
            dependencies: [
                .target(name: "SwiftExplorer"),
                .external(name: "SnapshotTesting"),
                .external(name: "CommonTest")
            ]
        ),
        .target(
            name: "ThemeTests",
            destinations: .macOS,
            product: .unitTests,
            bundleId: "com.joaolfp.ThemeTests",
            sources: ["Theme/Tests/**"],
            resources: [],
            dependencies: [
                .external(name: "Theme")
            ]
        ),
        .target(
            name: "LowlevelTests",
            destinations: .macOS,
            product: .unitTests,
            bundleId: "com.joaolfp.LowlevelTests",
            sources: ["Lowlevel/Tests/**"],
            resources: [],
            dependencies: [
                .external(name: "Lowlevel")
            ]
        ),
    ],
    schemes: Project.schemes()
)

public extension Project {

    static func schemes() -> [Scheme] {
        return [
            .scheme(
                name: "SwiftExplorer",
                buildAction: .buildAction(targets: ["SwiftExplorer"]),
                testAction: .targets(
                    ["SwiftExplorerTests", "ThemeTests", "LowlevelTests"],
                    options: .options(
                        coverage: true,
                        codeCoverageTargets: ["SwiftExplorer"]
                    )
                )
            )
        ]
    }
}
