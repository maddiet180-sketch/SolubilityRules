//
//  CompoundView.swift
//  Solubility Rules
//
//  Created by Madeline Moody on 8/29/26.
//

import SwiftUI

struct CompoundView: View {
    let question: Question
    var height: CGFloat = 160
    var overlap: CGFloat = 10
    var emotion: Emotion = .resting
    var isDissolving: Bool = false

    private var face: Emotion {
        if isDissolving && emotion == .resting { return .dissolving }
        return emotion
    }
    /// seperate atoms if the compound is in the water and it is soluble
    private var separated: Bool { isDissolving && question.isSoluble }

    var body: some View {
        let cation = question.cation.radius
        let anion = question.anion.radius
        let maxRadius = max(cation, anion)
        let sep = separated ? height * 0.7 : 0

        HStack(spacing: -overlap) {
            AtomView(ion: question.cation)
                .emotion(face)
                .frame(height: height * cation / maxRadius)
                .offset(x: -sep)
            AtomView(ion: question.anion)
                .emotion(face)
                .frame(height: height * anion / maxRadius)
                .offset(x: sep)
        }
        .animation(.easeIn(duration: 2), value: isDissolving)
    }
}

#Preview {
    if let question = QuestionDatabase.all.first {
        CompoundView(question: question)
    }
}
