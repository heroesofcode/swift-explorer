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
                .swiftlint,
                .swiftgen,
                .crashlytics
            ],
            dependencies: [
                .package(product: "Common"),
                .package(product: "Analytics"),
                .package(product: "DesignSystem"),
                .package(product: "Lowlevel")
            ],
            settings: .app,
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
            settings: .tests
        )
    ]
)
