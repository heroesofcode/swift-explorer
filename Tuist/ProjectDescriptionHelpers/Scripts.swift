import ProjectDescription

public extension TargetScript {
    static let swiftgen = TargetScript.pre(
        script: """
        export PATH="$HOME/.local/bin:/opt/homebrew/bin:/usr/local/bin:$PATH"
        if command -v mise >/dev/null 2>&1; then
            mise run swiftgen
        else
            echo "error: mise not found, cannot generate SwiftGen sources. Install mise: https://mise.jdx.dev"
            exit 1
        fi
        """,
        name: "SwiftGen",
        inputPaths: [
            "$(SRCROOT)/swiftgen.yml",
            "$(SRCROOT)/Sources/Localizable/**/*.strings"
        ],
        outputPaths: [
            "$(SRCROOT)/Sources/Generated/L10n.swift"
        ]
    )

    static let swiftlint = TargetScript.pre(
        script: """
        export PATH="$HOME/.local/bin:/opt/homebrew/bin:/usr/local/bin:$PATH"
        if command -v mise >/dev/null 2>&1; then
            mise run swiftlint
        else
            echo "warning: mise not found, skipping SwiftLint. Install mise: https://mise.jdx.dev"
        fi
        """,
        name: "SwiftLint",
        basedOnDependencyAnalysis: false
    )

    static let crashlytics = TargetScript.post(
        script: "",
        name: "Crashlytics",
        inputPaths: [
            "$(DWARF_DSYM_FOLDER_PATH)/$(DWARF_DSYM_FILE_NAME)",
            "$(DWARF_DSYM_FOLDER_PATH)/$(DWARF_DSYM_FILE_NAME)/Contents/Resources/DWARF/$(PRODUCT_NAME)",
            "$(DWARF_DSYM_FOLDER_PATH)/$(DWARF_DSYM_FILE_NAME)/Contents/Info.plist",
            "$(TARGET_BUILD_DIR)/$(UNLOCALIZED_RESOURCES_FOLDER_PATH)/GoogleService-Info.plist",
            "$(TARGET_BUILD_DIR)/$(EXECUTABLE_PATH)"
        ]
    )
}
