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
                    "CFBundleShortVersionString": "1.7.0",
                    "CFBundleVersion": "1",
                    "UIUserInterfaceStyle": "Dark"
                ]),
                sources: ["SwiftExplorer/**"],
                resources: [
                    "SwiftExplorer/Assets.xcassets",
                    "SwiftExplorer/Localizable/en.lproj/**",
                    "SwiftExplorer/Preview Content/**",
                    "SwiftExplorer/GoogleService-Info.plist"
                ],
                scripts: Project.targetScripts(),
                dependencies: [
                    .target(name: "Theme"),
                    .target(name: "Lowlevel"),
                    .target(name: "Analytics"),
                    .target(name: "Gemini"),
                    .external(name: "CodeEditor")
                ], 
                settings: .settings(configurations: [
                    // Other Linker Flags
                    .debug(name: "Debug", settings: ["OTHER_LDFLAGS": "-ObjC"]),
                    .release(name: "Release", settings: ["OTHER_LDFLAGS": "-ObjC"])
                ])
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
                    "Theme/Sources/Resources/**"
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
                    "Lowlevel/Sources/Localizable/en.lproj/**"
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
                name: "Analytics",
                destinations: .macOS,
                product: .staticFramework,
                bundleId: "com.joaolfp.Analytics",
                deploymentTargets: .macOS("14.0"),
                sources: ["Analytics/Sources/**"],
                resources: [],
                dependencies: [
                    .external(name: "FirebaseAnalytics")
                ]
            ),
            .target(
                name: "AnalyticsTests",
                destinations: .macOS,
                product: .unitTests,
                bundleId: "com.joaolfp.AnalyticsTests",
                sources: ["Analytics/Tests/**"],
                resources: [],
                dependencies: [
                    .target(name: "Analytics")
                ]
            ),
            .target(
                name: "Gemini",
                destinations: .macOS,
                product: .staticFramework,
                bundleId: "com.joaolfp.Gemini",
                deploymentTargets: .macOS("14.0"),
                sources: ["Gemini/Sources/**"],
                resources: [],
                dependencies: [
                    .external(name: "GoogleGenerativeAI")
                ]
            ),
            .target(
                name: "GeminiTests",
                destinations: .macOS,
                product: .unitTests,
                bundleId: "com.joaolfp.GeminiTests",
                sources: ["Gemini/Tests/**"],
                resources: [],
                dependencies: [
                    .target(name: "Gemini")
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
