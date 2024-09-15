//
//  CompareView.swift
//  Analytics
//
//  Created by João Lucas on 15/09/24.
//

import SwiftUI
import Theme

struct CompareView: View, Hashable {
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(Color.red)
                .frame(width: 200, height: 200)
        }
        .navigationTitle("Details")
    }
}
