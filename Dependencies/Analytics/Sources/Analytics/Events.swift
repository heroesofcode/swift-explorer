//
//  Events.swift
//  Analytics
//
//  Created by João Lucas on 08/09/24.
//

import Foundation

public enum AnalyticsEvents {

    public enum Home: String {
        case view = "home_view"
        case button = "generate_button"
        case empty_field = "empty_field"
    }
    
    public enum Compare: String {
        case view = "compare_view"
        case button = "review_button"
        case success = "review_success"
        case error = "review_error"
    }
}
