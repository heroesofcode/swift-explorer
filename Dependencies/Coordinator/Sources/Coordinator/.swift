//
//  ViewModel.swift
//  Coordinator
//
//  Created by João Lucas on 28/02/25.
//

import Foundation
import SwiftUI

open class ViewModel: ObservableObject, Hashable, Identifiable {
    public static func == (lhs: ViewModel, rhs: ViewModel) -> Bool {
        lhs === rhs
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }

    public init() { }
}
