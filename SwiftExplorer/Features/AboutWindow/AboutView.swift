//
//  AboutView.swift
//  SwiftExplorer
//
//  Created by João Lucas on 09/07/25.
//

import SwiftUI
import Common
import DesignSystem

struct AboutView: View {
    
    var body: some View {
        VStack {
            Image(nsImage: NSApp.applicationIconImage)
                .resizable()
                .frame(width: 96, height: 100)
                .cornerRadius(20)

            Text(L10n.swiftExplorer)
                .font(.title)
                .bold()

            Text(L10n.version(Bundle.main.appVersion))
                .foregroundColor(ThemeAsset.grayClear.swiftUIColor)

            Divider()

            if let contributeURL = contributeURL {
                linkButton(
                    url: contributeURL,
                    title: L10n.contribute
                )
            }

            if let licenseURL = licenseURL {
                linkButton(
                    url: licenseURL,
                    title: L10n.license
                )
            }
            
            Spacer()
            
            Text(L10n.heroesOfCode)
                .font(.footnote)
                .foregroundColor(.secondary)
        }
        .padding()
        .frame(width: 360, height: 420)
    }
    
    private func linkButton(url: URL, title: String) -> some View {
        Link(destination: url) {
            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(ThemeAsset.white.swiftUIColor)
                .frame(maxWidth: .infinity)
                .frame(height: 10)
                .padding()
                .background(ThemeAsset.swift.swiftUIColor)
                .cornerRadius(8)
                .contentShape(Rectangle())
        }
    }

    private var contributeURL: URL? {
        URL(string: AppLinks.github.rawValue)
    }

    private var licenseURL: URL? {
        URL(string: AppLinks.license.rawValue)
    }
}
