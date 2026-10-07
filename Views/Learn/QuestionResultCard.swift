//
//  QuestionResultCard.swift
//  Solubility Rules
//
//  Created by Madeline Moody on 8/29/26.
//

import SwiftUI

struct QuestionResult: Identifiable {
    let id = UUID()
    let question: Question
    let wasCorrect: Bool
    let isLast: Bool
}

/// Centered, chrome-less result card shown after CHECK. Sits over a translucent
/// scrim; the caller's `onClose` handles both the button and scrim taps.
struct QuestionResultCard: View {
    let result: QuestionResult
    var onClose: () -> Void

    @State private var showWhy = false

    private var question: Question { result.question }
    private var advanceLabel: String { result.isLast ? "Finish" : "Next Question" }
    /// "AgCl is not soluble" / "NaCl is soluble"
    private var statement: String {
        "\(question.formula) \(question.isSoluble ? "is" : "is not") soluble"
    }

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Spacer()
                Button(action: onClose) {
                    Image(systemName: "xmark")
                        .font(.headline.weight(.bold))
                        .foregroundStyle(.primaryCream)
                }
            }

            if result.wasCorrect {
                correctContent
            } else {
                wrongContent
            }
        }
        .padding(24)
        .frame(maxWidth: 420)
    }

    // MARK: Correct

    private var correctContent: some View {
        VStack(spacing: 16) {
            Text("Correct!")
                .font(.appFont(34))
            Text(statement)
                .font(.title2.bold())

            if showWhy {
                explanation
                Button(advanceLabel, action: onClose)
                    .buttonStyle(OutlinedButtonStyle())
            } else {
                HStack(spacing: 12) {
                    Button("Why?") { withAnimation { showWhy = true } }
                        .buttonStyle(OutlinedButtonStyle())
                    Button(advanceLabel, action: onClose)
                        .buttonStyle(OutlinedButtonStyle())
                }
            }
        }
        .foregroundStyle(.primaryCream)
        .multilineTextAlignment(.center)
    }

    // MARK: Wrong

    private var wrongContent: some View {
        VStack(spacing: 16) {
            Text("\(question.formula) is \(question.isSoluble ? "soluble" : "insoluble")!")
                .font(.appFont(30))
            explanation
            Button(advanceLabel, action: onClose)
                .buttonStyle(OutlinedButtonStyle())
        }
        .foregroundStyle(.primaryCream)
        .multilineTextAlignment(.center)
    }

    // MARK: Shared

    private var explanation: some View {
        VStack(spacing: 12) {
            Text(question.explanation.text)
                .font(.body)
            if let image = question.explanation.image {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 160)
            }
        }
    }
}

#Preview {
    ZStack {
        Color.primaryBrown.opacity(0.99).ignoresSafeArea()
        if let q = QuestionDatabase.all.first {
            QuestionResultCard(
                result: QuestionResult(question: q, wasCorrect: true, isLast: false)
            ) {}
        }
    }
}
