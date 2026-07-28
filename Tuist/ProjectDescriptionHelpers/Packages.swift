import ProjectDescription

public extension Package {
    static let all: [Package] = [
        .package(path: "Modules/Common"),
        .package(path: "Modules/CommonTest"),
        .package(path: "Modules/Analytics"),
        .package(path: "Modules/DesignSystem"),
        .package(path: "Modules/Lowlevel")
    ]
}

public extension TargetDependency {
    static let common = TargetDependency.package(product: "Common")
    static let commonTest = TargetDependency.package(product: "CommonTest")
    static let analytics = TargetDependency.package(product: "Analytics")
    static let designSystem = TargetDependency.package(product: "DesignSystem")
    static let lowlevel = TargetDependency.package(product: "Lowlevel")
}
