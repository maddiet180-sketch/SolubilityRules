//
//  TextShadow.swift
//  Solubility Rules
//
//  Created by Madeline Moody on 8/29/26.
//

import SwiftUI

// View modifier to make shadow around text

struct TextShadowModifier: ViewModifier {
    var offsetX: CGFloat = 2
    var offsetY: CGFloat = 2
    var shadowColor: Color = .primaryBrown
    private let symbolID = "strokeSymbol"
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .offset(x: +offsetX, y: +offsetY)
                .foregroundStyle(shadowColor)
            content
        }
    }
}

extension View {
    func textShadow(x: CGFloat, y: CGFloat, color: Color) -> some View {
        self.modifier(TextShadowModifier(offsetX: x, offsetY: y, shadowColor: color))
    }
}
