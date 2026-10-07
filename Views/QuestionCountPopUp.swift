//
//  QuestionCountPicker.swift
//  Solubility Rules
//
//  Created by Madeline Moody on 8/29/26.
//

import SwiftUI

struct QuestionCountPopUp: View {
    @Binding var count: Int
    let maxCount: Int
    var onStart: (Int) -> Void

    var body: some View {
        VStack(spacing: 24) {
            Text("How many questions?")
                .font(.headline)

            if maxCount >= 2 {
                Slider(
                    value: Binding(
                        get: { Double(count) },
                        set: { count = Int($0.rounded()) }
                    ),
                    in: 1...Double(maxCount),
                    step: 1
                )

                Text("\(count)")
                    .font(.title2.bold())
                    .monospacedDigit()
            } else {
                Text(maxCount == 1 ? "Only 1 question available" : "No questions available")
                    .foregroundStyle(.secondary)
            }

            Button("Start") { onStart(min(max(count, 1), max(maxCount, 1))) }
                .buttonStyle(OutlinedButtonStyle())
                .disabled(maxCount < 1)
        }
        .padding(24)
        .presentationDetents([.height(260)])
        .onAppear { count = min(max(count, 1), max(maxCount, 1)) }
    }
}

#Preview {
    QuestionCountPopUp(count: .constant(3), maxCount: 10) { _ in }
}
