//
//  ViewModel.swift
//  Common
//
//  Created by João Lucas on 12/07/25.
//

import SwiftUI

/// `ViewModel` is a SwiftUI property wrapper that injects an `ObservableObject`
/// from the global `SwiftInject` container and manages its lifecycle using `@StateObject`.
///
/// It simplifies dependency injection in SwiftUI views by automatically resolving
/// and observing a view model from the container.
///
/// Usage:
/// ```swift
/// struct MyView: View {
///     @ViewModel var viewModel: MyViewModel
///
///     var body: some View {
///         Text(viewModel.title)
///     }
/// }
/// ```
///
/// - Note: The type `T` must conform to `ObservableObject` and be registered in `SwiftInject`.
@propertyWrapper
public struct ViewModel<T: ObservableObject>: DynamicProperty {
    
    /// The internal state object resolved from the DI container.
    @StateObject private var stateObject: T

    /// The injected observable object instance.
    public var wrappedValue: T {
        stateObject
    }

    /// The projected value for SwiftUI bindings.
    public var projectedValue: ObservedObject<T>.Wrapper {
        return ObservedObject(wrappedValue: stateObject).projectedValue
    }

    /// Initializes the wrapper and resolves the dependency using the global DI container.
    public init() {
        _stateObject = StateObject(wrappedValue: di.get())
    }
}
