//
//  SolubilityQuestionDatabase.swift
//  Solubility Rules
//
//  Created by Madeline Moody on 8/29/26.
//

import Foundation

enum QuestionDatabase {

    static let all: [Question] = [

        Question(
            id: "NaCl", name: "sodium chloride", formula: "NaCl",
            isSoluble: true,
            hint: "Check the cation before the anion.",
            explanation: .init(
                text: "All Group 1 (alkali metal) salts are soluble, so every sodium compound dissolves.",
                image: nil
            ),
            cation: .sodium, anion: .chloride
        ),
        
        Question(
            id: "NaCl2", name: "sodium chloridee", formula: "NaCl2",
            isSoluble: false,
            hint: "Check the cation before the anion.",
            explanation: .init(
                text: "All Group 1 (alkali metal) salts are soluble, so every sodium compound dissolves.",
                image: nil
            ),
            cation: .sodium, anion: .chloride
        ),

//        Question(
//            id: "AgCl", name: "silver chloride", formula: "AgCl",
//            isSoluble: false,
//            hint: "Chlorides usually dissolve — but not with every metal.",
//            explanation: .init(
//                text: "Chlorides, bromides, and iodides are soluble except when paired with Ag⁺, Pb²⁺, or Hg₂²⁺.",
//                image: nil
//            ),
//            cation: .silver, anion: .chloride
//        ),
//
//        Question(
//            id: "KNO₃", name: "potassium nitrate", formula: "KNO₃",
//            isSoluble: true,
//            hint: "Some anions make everything dissolve.",
//            explanation: .init(
//                text: "All nitrates (NO₃⁻) are soluble, with no exceptions.",
//                image: nil
//            ),
//            cation: .potassium, anion: .nitrate
//        ),
//
//        Question(
//            id: "AgNO₃", name: "silver nitrate", formula: "AgNO₃",
//            isSoluble: true,
//            hint: "One rule here has no exceptions; the other has several.",
//            explanation: .init(
//                text: "Silver salts are often insoluble, but the nitrate rule wins: all nitrates are soluble.",
//                image: nil
//            ),
//            cation: .silver, anion: .nitrate
//        ),

    ]

    static let byID: [String: Question] =
        Dictionary(uniqueKeysWithValues: all.map { ($0.id, $0) })

    static func question(_ id: String) -> Question? { byID[id] }
}
