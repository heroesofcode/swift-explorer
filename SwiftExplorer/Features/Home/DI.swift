//
//  DI.swift
//  SwiftExplorer
//
//  Created by João Lucas on 12/07/25.
//

import Common

let homeModule: (SwiftInject) -> Void = {
    $0.factory { HomeViewModel() }
}
