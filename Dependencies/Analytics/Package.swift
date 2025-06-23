// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "Analytics",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "Analytics",
            targets: ["Analytics"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/firebase/firebase-ios-sdk", exact: "11.15.0")
    ],
    targets: [
        .target(
            name: "Analytics",
            dependencies: [
                .product(name: "FirebaseAnalytics", package: "firebase-ios-sdk"),
                .product(name: "FirebaseCrashlytics", package: "firebase-ios-sdk")
            ]
        ),
        .testTarget(
            name: "AnalyticsTests",
            dependencies: ["Analytics"]
        )
    ]
)
