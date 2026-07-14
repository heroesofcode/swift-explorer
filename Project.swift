import ProjectDescription

let project = Project(
    name: "SwiftExplorer",
    packages: [
        .package(path: "Dependencies/CommonTest"),
        .package(path: "Dependencies/Analytics"),
        .package(path: "Dependencies/Lowlevel"),
        .package(url: "https://github.com/lukepistrol/SwiftLintPlugin", .exact("0.63.1"))
    ],
    targets: [
        .target(
            name: "SwiftExplorer",
            destinations: .macOS,
            product: .app,
            bundleId: "com.joaolfp.SwiftExplorer",
            deploymentTargets: .macOS("14.0"),
            infoPlist: .extendingDefault(
                with: [
                    "CFBundleDisplayName": "Swift Explorer",
                    "LSApplicationCategoryType": "public.app-category.developer-tools",
                    "NSHumanReadableCopyright": "",
                    "UIUserInterfaceStyle": "Light"
                ]
            ),
            sources: ["SwiftExplorer/**/*.swift"],
            resources: [
                "SwiftExplorer/Assets.xcassets",
                "SwiftExplorer/Preview Content/**",
                "SwiftExplorer/GoogleService-Info.plist",
                "SwiftExplorer/Localizable/SwiftExplorer.strings"
            ],
            entitlements: .file(path: "SwiftExplorer/SwiftExplorer.entitlements"),
            scripts: [
                .post(
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
            ],
            dependencies: [
                .project(target: "Common", path: "Dependencies/Common"),
                .project(target: "DesignSystem", path: "Dependencies/DesignSystem"),
                .package(product: "Analytics"),
                .package(product: "Lowlevel"),
                .package(product: "SwiftLint", type: .plugin)
            ],
            settings: .settings(
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
            ),
            launchArguments: [
                .launchArgument(name: "-FIRAnalyticsDebugEnabled", isEnabled: true),
                .launchArgument(name: "-FIRDebugEnabled", isEnabled: true)
            ]
        ),
        .target(
            name: "SwiftExplorerTests",
            destinations: .macOS,
            product: .unitTests,
            bundleId: "com.joaolfp.SwiftExplorerTests",
            deploymentTargets: .macOS("14.5"),
            infoPlist: .extendingDefault(with: ["UIUserInterfaceStyle": "Dark"]),
            sources: ["SwiftExplorerTests/**/*.swift"],
            dependencies: [
                .target(name: "SwiftExplorer"),
                .package(product: "CommonTest")
            ],
            settings: .settings(
                base: [
                    "CODE_SIGN_STYLE": "Automatic",
                    "CURRENT_PROJECT_VERSION": "1",
                    "MARKETING_VERSION": "1.0",
                    "SWIFT_VERSION": "5.0"
                ]
            )
        )
    ]
)
