//
//  SwiftInject.swift
//  Common
//
//  Created by João Lucas on 12/07/25.
//

import Foundation

/// `SwiftInject` is a lightweight dependency injection container written in Swift.
/// It supports registering singleton instances, simple factories, and parameterized factories.
public final class SwiftInject {
    
    // MARK: - Internal Storage

    /// Stores singleton instances keyed by their type.
    private var singletons: [ObjectIdentifier: Any] = [:]

    /// Stores factory closures for creating instances on demand.
    private var factories: [ObjectIdentifier: () -> Any] = [:]

    /// Stores parameterized factory closures that accept an external parameter.
    private var parameterizedFactories: [ObjectIdentifier: (Any) -> Any] = [:]

    // MARK: - Initialization

    /// Initializes a new instance of the SwiftInject container.
    public init() {}

    /// Starts the DI container by applying all provided modules (configurations).
    ///
    /// - Parameter modules: An array of modules, each being a closure that registers dependencies into the container.
    /// - Returns: A fully configured `SwiftInject` instance.
    public static func start(modules: [(SwiftInject) -> Void]) -> SwiftInject {
        let swiftInject = SwiftInject()
        
        for module in modules {
            module(swiftInject)
        }
        
        return swiftInject
    }

    // MARK: - Registration

    /// Registers a singleton instance for the specified type.
    ///
    /// - Parameter builder: A closure that builds and returns the singleton instance.
    public func single<T>(_ builder: @escaping () -> T) {
        singletons[ObjectIdentifier(T.self)] = builder()
    }

    /// Registers a factory for creating new instances on demand.
    ///
    /// - Parameter builder: A closure that returns a new instance each time it is called.
    public func factory<T>(_ builder: @escaping () -> T) {
        factories[ObjectIdentifier(T.self)] = builder
    }

    /// Registers a parameterized factory for creating new instances with input parameters.
    ///
    /// - Parameter builder: A closure that accepts a parameter and returns a new instance.
    public func factory<T, P>(_ builder: @escaping (P) -> T) {
        parameterizedFactories[ObjectIdentifier(T.self)] = { anyParam in
            guard let param = anyParam as? P else {
                fatalError("❌ Invalid parameter type for \(T.self). Expected \(P.self).")
            }
            
            return builder(param)
        }
    }

    // MARK: - Resolution

    /// Resolves an instance of the specified type.
    ///
    /// - Returns: The resolved instance.
    /// - Note: If no provider is found for the type, the method triggers a fatal error.
    public func get<T>() -> T {
        let id = ObjectIdentifier(T.self)

        if let instance = singletons[id] as? T {
            return instance
        }

        if let factory = factories[id],
           let instance = factory() as? T {
            return instance
        }

        fatalError("❌ No provider registered for \(T.self)")
    }

    /// Resolves an instance of the specified type using a parameter.
    ///
    /// - Parameter params: The parameter to be passed to the factory.
    /// - Returns: The resolved instance.
    /// - Note: If no parameterized factory is registered for the type, the method triggers a fatal error.
    public func get<T, P>(params: P) -> T {
        let id = ObjectIdentifier(T.self)

        if let factory = parameterizedFactories[id],
           let instance = factory(params) as? T {
            return instance
        }

        fatalError("❌ No parameterized factory registered for \(T.self)")
    }
}
