//
//  Word.swift
//  wordleGame
//
//  Created by Fabiana Lozada on 6/2/25.
//

import SwiftUI

enum LetterStatus: Int {
    case empty = 0, wrong, misplaced, correct

    var color: Color {
        switch self {
        case .empty: return Color.gray.opacity(0.3)
        case .wrong: return Color.gray
        case .misplaced: return Color.yellow
        case .correct: return Color.green
        }
    }

    var priority: Int {
        return self.rawValue
    }
}

struct Letter {
    var character: String
    var status: LetterStatus
}

