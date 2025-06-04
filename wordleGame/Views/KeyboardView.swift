//
//  KeyboardView.swift
//  wordleGame
//
//  Created by Fabiana Lozada on 6/2/25.
//


import SwiftUI

struct KeyboardView: View {
    let keyboardRows = ["QWERTYUIOP", "ASDFGHJKL", "ZXCVBNM"]
    var viewModel: WordleViewModel

    var body: some View {
        VStack {
            ForEach(keyboardRows, id: \.self) { row in
                HStack {
                    ForEach(Array(row), id: \.self) { key in
                        Button(action: {
                            viewModel.enterLetter(String(key))
                        }) {
                            Text(String(key))
                                .frame(width: 30, height: 40)
                                .background(viewModel.keyboardColors[String(key)]?.color ?? Color.gray.opacity(0.3))
                                .foregroundColor(.black)
                                .cornerRadius(5)
                        }
                    }
                }
            }
            HStack {
                Button("Delete") { viewModel.deleteLetter() }
                    .padding()
                Button("Enter") { viewModel.submitGuess() }
                    .padding()
            }
        }
    }
}
