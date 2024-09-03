import ProjectDescription

public extension Project {

    static func targetScripts() -> [TargetScript] {
        return [
            TargetScript.pre(
                script:
                """
                export PATH="$HOME/.local/share/mise/shims:$PATH"
                swiftgen
                """,
                name: "SwiftGen",
                basedOnDependencyAnalysis: false
            )
        ]
    }
}
