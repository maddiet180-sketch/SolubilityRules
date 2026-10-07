//
//  TextOutline.swift
//  Solubility Rules
//
//  Created by Madeline Moody on 8/29/26.
//

import SwiftUI

// View modifier to outline text. Addapted from the article "How to Create Outlined Text in SwiftUI"
// written by Garejakirit on Medium.

struct TextStrokeModifier: ViewModifier {
    var strokeSize: CGFloat = 2
    var strokeColor: Color = .primaryBrown
    private let symbolID = "strokeSymbol"
    
    func body(content: Content) -> some View {
        content
            .padding(strokeSize)
            .background(
                Rectangle()
                    .foregroundStyle(strokeColor)
                    .mask(outline(on: content))
            )
    }
    
    func outline(on content: Content) -> some View {
        Canvas { context, size in
            context.addFilter(.alphaThreshold(min: 0.01))
            context.drawLayer { layer in
                if let symbol = context.resolveSymbol(id: symbolID) {
                    layer.draw(symbol, at: CGPoint(x: size.width / 2, y: size.height / 2))
                }
            }
        } symbols: {
            content
                .tag(symbolID)
                .blur(radius: strokeSize)
        }
    }
}

extension View {
    func textStroke(width: CGFloat, color: Color) -> some View {
        self.modifier(TextStrokeModifier(strokeSize: width, strokeColor: color))
    }
}
