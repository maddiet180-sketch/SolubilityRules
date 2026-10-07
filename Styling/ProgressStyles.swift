//
//  ProgressStyles.swift
//  Solubility Rules
//
//  Created by Madeline Moody on 8/29/26.
//

import SwiftUI

struct ThickerProgressStyle: ProgressViewStyle {
    var height: CGFloat = 16
    var track: Color = .accentYellow1
    var fill: Color = .accentOrange1

    func makeBody(configuration: Configuration) -> some View {
        let fraction = configuration.fractionCompleted ?? 0
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Capsule().fill(track)
                Capsule().fill(fill)
                    .frame(width: max(0, geo.size.width * fraction))
            }
        }
        .frame(height: height)
        .animation(.easeInOut(duration: 0.25), value: fraction)
    }
}
