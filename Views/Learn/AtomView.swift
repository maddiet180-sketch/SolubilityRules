//
//  AtomView.swift
//  Solubility Rules
//
//  Created by Madeline Moody on 8/29/26.
//

import SwiftUI

struct AtomView: View {
    let ion: Ion
    var emotion: Emotion = .resting
    var secondsPerBlink: Double = 2

    @State private var isBlinking = false

    /// Blink only if resting
    private var shown: Emotion {
        emotion == .resting && isBlinking ? .blinking : emotion
    }

    var body: some View {
        ZStack {
            Image(ion.baseImage)
                .resizable()
                .scaledToFit()

            // Faces controlled by opacity
            ForEach(Emotion.allCases, id: \.self) { face in
                Image(ion.face(face))
                    .resizable()
                    .scaledToFit()
                    .opacity(face == shown ? 1 : 0)
            }
        }
        .animation(.easeInOut(duration: 0.12), value: shown)
        .task(id: emotion) {
            isBlinking = false
            guard emotion == .resting else { return }
            while !Task.isCancelled {
                try? await Task.sleep(for: .seconds(secondsPerBlink + .random(in: 0...1.5)))
                guard emotion == .resting else { break }
                isBlinking = true
                try? await Task.sleep(for: .milliseconds(110))
                isBlinking = false
            }
        }
    }
}

extension AtomView {
    func emotion(_ emotion: Emotion) -> AtomView {
        var copy = self
        copy.emotion = emotion
        return copy
    }
}

#Preview {
    if let question = QuestionDatabase.all.first {
        HStack(spacing: 32) {
            AtomView(ion: question.cation).emotion(.happy)
            AtomView(ion: question.anion).emotion(.sad)
        }
        .padding()
    }
}
