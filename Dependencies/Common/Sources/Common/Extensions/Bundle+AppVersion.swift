//
//  Bundle+AppVersion.swift
//  Common
//
//  Created by João Lucas on 09/07/25.
//

import Foundation

/// Extension to search app version
public extension Bundle {
    
    var appVersion: String {
        let version = infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
        let build = infoDictionary?["CFBundleVersion"] as? String ?? "?"
        return "\(version) (\(build))"
    }
}
