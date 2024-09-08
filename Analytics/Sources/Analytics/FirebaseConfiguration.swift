//
//  FirebaseConfiguration.swift
//  Analytics
//
//  Created by João Lucas on 08/09/24.
//

import FirebaseCore
import Foundation

public enum FirebaseConfiguration {

    public static func start() {
        FirebaseApp.configure()
    }
}
