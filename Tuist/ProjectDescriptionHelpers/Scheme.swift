import ProjectDescription

public extension Project {
    
    static func schemes() -> [Scheme] {
        return [
            .scheme(
                name: "SwiftExplorer",
                buildAction: .buildAction(targets: ["SwiftExplorer"]),
                testAction: .targets(
                    ["SwiftExplorerTests",
                     "ThemeTests",
                     "LowlevelTests",
                     "AnalyticsTests",
                     "GeminiTests"
                    ],
                    options: .options(
                        coverage: true,
                        codeCoverageTargets: [
                            "SwiftExplorer",
                            "Theme",
                            "Lowlevel",
                            "Analytics",
                            "Gemini"
                        ]
                    )
                ),
                runAction: .runAction(
                    configuration: .debug,
                    arguments: .arguments(
                        launchArguments: [
                            .launchArgument(name: "-FIRAnalyticsDebugEnabled", isEnabled: true),
                            .launchArgument(name: "-FIRDebugEnabled", isEnabled: true)
                        ]
                    )
                )
            )
        ]
    }
}
