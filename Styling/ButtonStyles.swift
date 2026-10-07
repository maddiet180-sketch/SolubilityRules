//
//  ButtonStyles.swift
//  Solubility Rules
//
//  Created by Madeline Moody on 8/28/26.
//

import SwiftUI

struct OutlinedButtonStyle: ButtonStyle {
    var background: Color = .accentOrange1
    var text: Color = .primaryCream
    var outline: Color = .primaryBrown

    private let cornerRadius: CGFloat = 50
    private let lineWidth: CGFloat = 6

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.appFont(40))
            .foregroundColor(text)
            .padding()
            .frame(maxWidth: .infinity)
            .background(background, in: RoundedRectangle(cornerRadius: cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .strokeBorder(outline, lineWidth: lineWidth)
            )
            .opacity(configuration.isPressed ? 0.7 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
    }
}
