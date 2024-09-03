import ProjectDescription

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
