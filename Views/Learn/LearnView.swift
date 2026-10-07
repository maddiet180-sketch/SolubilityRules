//
//  LearnView.swift
//  Solubility Rules
//
//  Created by Madeline Moody on 8/28/26.
//

import SwiftUI

struct LearnView: View {
    @StateObject private var learnVM: LearnViewModel
    @Environment(\.dismiss) private var dismiss
    
    /// popup states
    @State private var isShowingHint: Bool = false
    
    /// compound dragging states
    @State private var compoundCenter: CGPoint = .zero
    @State private var dragStart: CGPoint? = nil
    @GestureState private var isDragging = false

    /// states needed fro checking answer
    @State private var canvasSize: CGSize = .zero
    @State private var lastAnswerCorrect: Bool? = nil
    @State private var isDissolving = false
    @State private var result: QuestionResult? = nil
    @State private var answerFace: Emotion? = nil

    init(questionCount: Int) {
        _learnVM = StateObject(wrappedValue: LearnViewModel(questionCount: questionCount))
    }

    var body: some View {
        GeometryReader { geo in
            ZStack {
                /// Water background
                WaterLoopBackground()
                    .ignoresSafeArea()
                
                /// Progress tracker and check button
                VStack(spacing: 16) {
                    header(geo.size)
                    compoundName(geo.size)
                        .padding(.top)
                    Spacer()
                    footer(geo.size)
                }
                .padding()
                
                /// Compound
                CompoundView(question: learnVM.currentQuestion,
                             height: compoundHeight(geo.size),
                             emotion: answerFace ?? (isDragging ? .surprised : .resting),
                             isDissolving: isDissolving)
                    .id(learnVM.index)
                    .position(compoundCenter)
                    .gesture(dragGesture,
                             including: (isDissolving || result != nil) ? .none : .all)
                
                /// Answer / explanation popup
                if let result {
                    Color.primaryBrown.opacity(0.5)
                        .ignoresSafeArea()
                        .contentShape(Rectangle())
                        .onTapGesture { advance(from: result) }
                        .transition(.opacity)

                    QuestionResultCard(result: result) { advance(from: result) }
                        .transition(.scale(scale: 0.9).combined(with: .opacity))
                }
            }
            .background(.primaryCream)
            .onAppear {
                canvasSize = geo.size
                compoundCenter = startPoint(geo.size)
            }
            .onChange(of: geo.size) { canvasSize = $0 }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }


    private func header(_ size: CGSize) -> some View {
        HStack(spacing: 12) {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title.weight(.bold))
            }

            ProgressView(value: learnVM.progress)
                .progressViewStyle(ThickerProgressStyle())
            
            Text(learnVM.progressText)
                .font(.appFont(size.width * 0.03))
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .layoutPriority(1)
        }
    }

    private func compoundName(_ size: CGSize) -> some View {
        return VStack {
            Text(learnVM.currentQuestion.formula)
                .font(.appFont(size.width * 0.08))
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
            Text(learnVM.currentQuestion.name)
                .font(.title2.bold())
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
        }
    }
    
    private func footer(_ size: CGSize) -> some View {
        ZStack {
            checkButton
                .frame(width: size.width * 0.25)
            HStack {
                Spacer()
                Button {
                    isShowingHint = true
                } label: {
                    Image(systemName: "lightbulb")
                        .font(.title.weight(.bold))
                        .foregroundStyle(.primaryCream)
                }
                .padding()
                .background(
                    Circle()
                        .fill(.primaryBrown)
                        .frame(width: size.width / 10)
                        .opacity(0.4)
                )
                .padding(.trailing)
            }
        }
    }
    
    // MARK: Question submission logic
    private var checkButton: some View {
        Button("CHECK") {
            let wasCorrect = learnVM.checkAnswer(userAnswer)
            lastAnswerCorrect = wasCorrect
            answerAnimations()
        }
        .buttonStyle(OutlinedButtonStyle())
        .disabled(isDissolving || result != nil)
    }

    private func answerAnimations() {
        guard let wasCorrect = lastAnswerCorrect else { return }
        let resultInfo = QuestionResult(question: learnVM.currentQuestion,
                                     wasCorrect: wasCorrect,
                                     isLast: learnVM.isLastQuestion)
        let face: Emotion = wasCorrect ? .happy : .sad
        let inWater = userAnswer

        Task { @MainActor in
            /// If the compound is in the water trigger dissolve animation
            if inWater {
                withAnimation { isDissolving = true }
                try? await Task.sleep(for: .seconds(1.0))
            }
            withAnimation { answerFace = face }
            try? await Task.sleep(for: .seconds(0.7))
            withAnimation { result = resultInfo }
        }
    }

    private func advance(from result: QuestionResult) {
        /// move onto next question and reset state
        withAnimation { self.result = nil }
        isDissolving = false
        answerFace = nil
        lastAnswerCorrect = nil
        if result.isLast {
            dismiss()
        } else {
            learnVM.nextQuestion()
            compoundCenter = startPoint(canvasSize)
        }
    }

    private var userAnswer: Bool {
        waterRect(canvasSize).contains(compoundCenter)
    }

    // MARK: Compound position tracking and drag gestures
    private var dragGesture: some Gesture {
        DragGesture()
            .updating($isDragging) { _, state, _ in
                state = true
            }
            .onChanged { value in
                let start = dragStart ?? compoundCenter
                dragStart = start
                compoundCenter = CGPoint(x: start.x + value.translation.width,
                                         y: start.y + value.translation.height)
            }
            .onEnded { _ in
                dragStart = nil
            }
    }
    
    private func startPoint(_ size: CGSize) -> CGPoint {
        CGPoint(x: size.width / 2, y: size.height * 0.3)
    }

    private func compoundHeight(_ size: CGSize) -> CGFloat {
        let base = min(size.width, size.height) * 0.30
        return min(max(base, 120), 300)
    }

    private func waterRect(_ size: CGSize) -> CGRect {
        CGRect(x: 0, y: size.height * 0.45,
               width: size.width, height: size.height * 0.55)
    }
}
