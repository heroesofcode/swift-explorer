import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "SwiftExplorer",
    packages: [
        .package(path: "Dependencies/Common"),
        .package(path: "Dependencies/CommonTest"),
        .package(path: "Dependencies/Analytics"),
        .package(path: "Dependencies/DesignSystem"),
        .package(path: "Dependencies/Lowlevel")
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
                .swiftgen,
                .crashlytics
            ],
            dependencies: [
                .package(product: "Common"),
                .package(product: "Analytics"),
                .package(product: "DesignSystem"),
                .package(product: "Lowlevel"),
                .external(name: "SwiftLint")
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
