//
//  AppTheme.swift
//  Solubility Rules
//
//  Created by Madeline Moody on 8/29/26.
//

import SwiftUI

// Swift Playgrounds packages don't auto-generate asset color symbols the way a
// normal Xcode app target does, so `.background(.primaryBrown)` won't resolve on
// its own. This extension is that bridge — each value looks the color up by name
// from Assets.xcassets (Bundle.main). Edit the colors themselves in the catalog.

extension ShapeStyle where Self == Color {
    static var primaryBrown: Color { Color("primaryBrown") }
    static var primaryCream: Color { Color("primaryCream") }

    static var accentBlue1: Color { Color("accentBlue1") }
    static var accentGreen1: Color { Color("accentGreen1") }
    static var accentOrange1: Color { Color("accentOrange1") }
    static var accentYellow1: Color { Color("accentYellow1") }
}

// App-wide constants for background and text

enum AppTheme {
    static let primaryBackground = Color.primaryCream
    static let primaryText = Color.primaryBrown
}

struct AppThemeModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(AppTheme.primaryText)
            .font(.system(.body, design: .rounded))
            .fontWeight(.heavy)
    }
}

struct AppBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(AppTheme.primaryBackground)
    }
}

extension View {
    func appTheme() -> some View {
        self.modifier(AppThemeModifier())
    }

    func appBackground() -> some View {
        self.modifier(AppBackgroundModifier())
    }
}
