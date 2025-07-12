//
//  SwiftInjectBuilder.swift
//  Common
//
//  Created by João Lucas on 12/07/25.
//

import Foundation

// swiftlint:disable identifier_name
/// Internal storage for the global SwiftInject container.
/// Access is provided via the `di` computed property.
private var _di: SwiftInject?

/// Global accessor for the dependency injection container.
///
/// - Returns: The initialized `SwiftInject` container.
/// - Throws: A fatal error if the container has not been initialized using `startDI(modules:)`.
public var di: SwiftInject {
    guard let container = _di else {
        fatalError("❌ DI container not initialized. Call `startDI(modules:)` before using it.")
    }
    return container
}

/// Initializes the global dependency injection container with the provided modules.
///
/// - Parameter modules: A list of module registration closures to configure the container.
///
/// This function must be called once at application startup, before accessing the `di` container.
public func startDI(modules: [(SwiftInject) -> Void]) {
    _di = SwiftInject.start(modules: modules)
}
