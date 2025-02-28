import SwiftUI

@MainActor
public protocol Coordinator: AnyObject, ObservableObject {
    var coordinator: (any Coordinator)? { get set }
    
    associatedtype V: View

    @discardableResult
    func start() -> PresentationModel
    func navigateTo(_ page: PresentationModel)
    func back()

    @ViewBuilder
    func createView(presentationModel: PresentationModel) -> V
}

// MARK: - Coordinator Default Implementation
public extension Coordinator {
    func navigateTo(_ page: PresentationModel) {
        coordinator?.navigateTo(page)
    }

    func back() {
        coordinator?.back()
    }
}

@MainActor
open class PresentationModel: ObservableObject, Hashable {
    public nonisolated let id = UUID()

    public init() { }

    public nonisolated static func == (lhs: PresentationModel, rhs: PresentationModel) -> Bool {
        lhs.id == rhs.id
    }

    public nonisolated func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
