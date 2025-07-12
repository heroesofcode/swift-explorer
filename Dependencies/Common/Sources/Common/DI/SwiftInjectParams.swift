//
//  SwiftInjectParams.swift
//  Common
//
//  Created by João Lucas on 12/07/25.
//

import SwiftUI

/// `SwiftInjectParams` is a SwiftUI property wrapper that resolves an `ObservableObject`
/// dependency from the global `SwiftInject` container using a parameter.
///
/// It integrates with SwiftUI’s `@StateObject` to ensure the object is properly retained
/// and updated during the view lifecycle.
///
/// Usage:
/// ```swift
/// struct MyView: View {
///     @SwiftInjectParams(MyParams(id: "abc")) var viewModel: MyViewModel
///
///     var body: some View {
///         Text(viewModel.title)
///     }
/// }
/// ```
///
/// - `T`: The type of the `ObservableObject` to resolve.
/// - `P`: The type of the parameter used to resolve the dependency.
@propertyWrapper
public struct SwiftInjectParams<T: ObservableObject, P>: DynamicProperty {
    
    /// The internal state object resolved from the DI container.
    @StateObject private var stateObject: T

    /// The injected dependency instance.
    public var wrappedValue: T {
        stateObject
    }

    /// The projected value for SwiftUI bindings.
    public var projectedValue: ObservedObject<T>.Wrapper {
        ObservedObject(wrappedValue: stateObject).projectedValue
    }

    /// Initializes the wrapper and resolves the dependency using the provided parameter.
    ///
    /// - Parameter param: A parameter of type `P` used to resolve the `ObservableObject`.
    public init(_ param: P) {
        let resolved: T = di.get(params: param)
        _stateObject = StateObject(wrappedValue: resolved)
    }
}
