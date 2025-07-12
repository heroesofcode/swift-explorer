//
//  Inject.swift
//  Common
//
//  Created by João Lucas on 12/07/25.
//

import Foundation

/// `Inject` is a property wrapper that provides a convenient way to access dependencies
/// registered in the global `SwiftInject` container.
///
/// Usage:
/// ```swift
/// class MyViewModel {
///     @Inject var service: MyService
/// }
/// ```
///
/// This automatically resolves `MyService` from the dependency injection container
/// using `di.get()`. If the container has not been initialized with `startDI(modules:)`,
/// a fatal error will be thrown.
@propertyWrapper
public struct Inject<T> {
    
    /// The resolved dependency of type `T`.
    public let wrappedValue: T

    /// Initializes and resolves the dependency from the DI container.
    public init() {
        self.wrappedValue = di.get()
    }
}
