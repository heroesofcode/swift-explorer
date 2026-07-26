import ProjectDescription

public extension Settings {
    static let app = Settings.settings(
        base: [
            "ASSETCATALOG_COMPILER_APPICON_NAME": "AppIcon",
            "ASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME": "AccentColor",
            "CODE_SIGN_STYLE": "Automatic",
            "COMBINE_HIDPI_IMAGES": "YES",
            "CURRENT_PROJECT_VERSION": "1",
            "DEVELOPMENT_ASSET_PATHS": "\"SwiftExplorer/Preview Content\"",
            "ENABLE_PREVIEWS": "YES",
            "ENABLE_USER_SCRIPT_SANDBOXING": "NO",
            "LD_RUNPATH_SEARCH_PATHS": ["$(inherited)", "@executable_path/../Frameworks"],
            "MARKETING_VERSION": "2.1.0",
            "SWIFT_EMIT_LOC_STRINGS": "YES",
            "SWIFT_VERSION": "5.0"
        ]
    )

    static let tests = Settings.settings(
        base: [
            "CODE_SIGN_STYLE": "Automatic",
            "CURRENT_PROJECT_VERSION": "1",
            "MARKETING_VERSION": "1.0",
            "SWIFT_VERSION": "5.0"
        ]
    )
}
