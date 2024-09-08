import ProjectDescription

public extension Project {
    
    static func targets() -> [Target] {
        return [
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
                scripts: Project.targetScripts(),
                dependencies: [
                    .target(name: "Theme"),
                    .target(name: "Lowlevel"),
                    .external(name: "CodeEditor")
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
                    .target(name: "CommonTest"),
                    .external(name: "SnapshotTesting")
                ]
            ),
            .target(
                name: "Theme",
                destinations: .macOS,
                product: .framework,
                bundleId: "com.joaolfp.Theme",
                deploymentTargets: .macOS("14.0"),
                sources: ["Theme/Sources/**"],
                resources: [
                    "Theme/Sources/Theme/Resources/**"
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
                    .target(name: "Theme")
                ]
            ),
            .target(
                name: "Lowlevel",
                destinations: .macOS,
                product: .framework,
                bundleId: "com.joaolfp.Lowlevel",
                deploymentTargets: .macOS("14.0"),
                sources: ["Lowlevel/Sources/**"],
                resources: [
                    "Lowlevel/Sources/Lowlevel/Localizable/en.lproj/**"
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
                    .target(name: "Lowlevel")
                ]
            ),
            .target(
                name: "CommonTest",
                destinations: .macOS,
                product: .framework,
                bundleId: "com.joaolfp.CommonTest",
                deploymentTargets: .macOS("14.0"),
                sources: ["CommonTest/Sources/**"],
                resources: []
            )
        ]
    }
}
