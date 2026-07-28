import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "SwiftExplorer",
    packages: Package.all,
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
            sources: ["Sources/**/*.swift"],
            resources: [
                "Sources/Assets.xcassets",
                "Sources/Preview Content/**",
                "Sources/GoogleService-Info.plist",
                "Sources/Localizable/SwiftExplorer.strings"
            ],
            entitlements: .file(path: "Sources/SwiftExplorer.entitlements"),
            scripts: [
                .swiftlint,
                .swiftgen,
                .crashlytics
            ],
            dependencies: [
                .common,
                .analytics,
                .designSystem,
                .lowlevel
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
            sources: ["Tests/**/*.swift"],
            dependencies: [
                .target(name: "SwiftExplorer"),
                .commonTest
            ],
            settings: .tests
        )
    ]
)
