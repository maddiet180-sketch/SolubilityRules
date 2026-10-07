//
//  LearnViewModel.swift
//  Solubility Rules
//
//  Created by Madeline Moody on 8/28/26.
//

import Foundation


final class LearnViewModel: ObservableObject {
    @Published private(set) var index = 0
    @Published private(set) var correctCount = 0
    @Published private(set) var isFinished = false
    let questions: [Question]
    let totalQuestions: Int
    
    init(questionCount: Int, possibleQuestions: [Question] = QuestionDatabase.all) {
        let safeQuestionCount = min(max(questionCount, 1), possibleQuestions.count)
        questions = Array(possibleQuestions.shuffled().prefix(safeQuestionCount))
        totalQuestions = questions.count
    }
    
    // Functions
    func nextQuestion() {
        if index < totalQuestions - 1 {
            index += 1
        } else {
            isFinished = true
        }
    }

    /// Records the answer and returns whether it was correct.
    func checkAnswer(_ userAnswer: Bool) -> Bool {
        let wasCorrect = currentQuestion.isSoluble == userAnswer
        if wasCorrect { correctCount += 1 }
        return wasCorrect
    }

    // Computed vars
    var currentQuestion: Question {
        questions[min(index, totalQuestions - 1)]
    }

    var isLastQuestion: Bool {
        index >= totalQuestions - 1
    }
    
    var completedQuestions: Int {
        min(max(0, index), totalQuestions - 1)
    }
    
    var progressText: String {
        return "\(completedQuestions) / \(totalQuestions)"
    }

    var progress: Double {
        totalQuestions == 0 ? 0 : Double(completedQuestions) / Double(totalQuestions)
    }
    
}
