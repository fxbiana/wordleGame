//
//  WordleViewModel.swift
//  wordleGame
//
//  Created by Fabiana Lozada on 6/2/25.
//


import SwiftUI


class WordleViewModel: ObservableObject {
    @Published var grid: [[Letter]] = []
    @Published var currentAttempt = 0
    @Published var currentGuess = ""
    @Published var showingWinAlert = false
    @Published var showingLoseAlert = false
    @Published var keyboardColors: [String: LetterStatus] = [:]

    var solution = "SWIFT"
    let maxAttempts = 6
    let wordLength = 5
    var allWords: [String] = []

    init() {
        loadWords()
        pickRandomWord()
        resetGrid()
    }

    func resetGrid() {
        grid = Array(repeating: Array(repeating: Letter(character: "", status: .empty), count: wordLength), count: maxAttempts)
        currentAttempt = 0
        currentGuess = ""
        keyboardColors = [:]
        pickRandomWord()  // Pick a new word every time you reset
        showingWinAlert = false
        showingLoseAlert = false
    }

    func enterLetter(_ letter: String) {
        guard currentGuess.count < wordLength else { return }
        currentGuess += letter.uppercased()
        updateGrid()
    }

    func deleteLetter() {
        guard !currentGuess.isEmpty else { return }
        currentGuess.removeLast()
        updateGrid()
    }

    func submitGuess() {
        guard currentGuess.count == wordLength else { return }

        for i in 0..<wordLength {
            let guessChar = Array(currentGuess)[i]
            let solutionChar = Array(solution)[i]

            let status: LetterStatus
            if guessChar == solutionChar {
                status = .correct
            } else if solution.contains(guessChar) {
                status = .misplaced
            } else {
                status = .wrong
            }

            grid[currentAttempt][i] = Letter(character: String(guessChar), status: status)
            let currentStatus = keyboardColors[String(guessChar)] ?? .empty
            if status.priority > currentStatus.priority {
                keyboardColors[String(guessChar)] = status
            }
        }

        if currentGuess.uppercased() == solution {
            showingWinAlert = true
        } else {
            currentAttempt += 1
            currentGuess = ""
            if currentAttempt >= maxAttempts {
                showingLoseAlert = true
            }
        }
    }

    func updateGrid() {
        for i in 0..<wordLength {
            grid[currentAttempt][i].character = i < currentGuess.count ? String(Array(currentGuess)[i]) : ""
            if i >= currentGuess.count {
                grid[currentAttempt][i].status = .empty
            }
        }
    }

    func loadWords() {
        if let path = Bundle.main.path(forResource: "words", ofType: "txt"),
           let contents = try? String(contentsOfFile: path) {
            allWords = contents.components(separatedBy: .newlines).filter { $0.count == 5 }
        }
    }

    func pickRandomWord() {
        solution = allWords.randomElement()?.uppercased() ?? "SWIFT"
    }
}
