//
//  AppFonts.swift
//  Solubility Rules
//
//  Created by Madeline Moody on 8/29/26.
//

import SwiftUI
import UIKit
import CoreText

enum AppFonts {
    /// Registers the bundled custom font. Call once at app launch.
    /// The .otf ships as the "CustomFont" data set in Assets.xcassets, since
    /// a .swiftpm app has no Info.plist to list UIAppFonts.
    static func register() {
        guard let asset = NSDataAsset(name: "CustomFont"),
              let provider = CGDataProvider(data: asset.data as CFData),
              let font = CGFont(provider) else {
            assertionFailure("CustomFont data set missing")
            return
        }
        CTFontManagerRegisterGraphicsFont(font, nil)
    }
}

extension Font {
    /// The app's custom font at a given point size.
    static func appFont(_ size: CGFloat) -> Font {
        .custom("Myfont-Regular", size: size)
    }
}
