//
//  Models.swift
//  Solubility Rules
//
//  Created by Madeline Moody on 8/29/26.
//

import Foundation

enum Emotion: String, Codable, CaseIterable {
    case resting, happy, sad, surprised, blinking, dissolving
}

struct Ion: Codable, Identifiable, Hashable {
    let id: String
    let name: String // "silver"
    let formula: String /// Chemical formula with charge "Ag⁺"
    let charge: Int  /// Ionic charge (+1)
    let baseImage: String
    let radius: Double /// Relative ionic radius (pm)

    /// Gets image name for a given emotion:`"<id>_face_<emotion>"`.
    func face(_ emotion: Emotion) -> String {
        "\(id)_face_\(emotion.rawValue)"
    }

    /// Charge formatted like "2-"
    var chargeText: String {
        let magnitude = abs(charge)
        let sign = charge < 0 ? "-" : "+"
        return magnitude <= 1 ? sign : "\(magnitude)\(sign)"
    }
}

struct Explanation: Codable, Hashable {
    let text: String
    let image: String?
}

struct Question: Codable, Identifiable, Hashable {
    let id: String
    let name: String /// Plain language name, "sodium chloride"
    let formula: String /// Chemical formula "NaCl".
    let isSoluble: Bool
    let hint: String
    let explanation: Explanation
    let cation: Ion
    let anion: Ion
}
