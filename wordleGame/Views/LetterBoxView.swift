//
//  LetterBoxView.swift
//  wordleGame
//
//  Created by Fabiana Lozada on 6/2/25.
//


import SwiftUI

struct LetterBoxView: View {
    let letter: Letter

    var body: some View {
        Text(letter.character)
            .frame(width: 40, height: 40)
            .background(letter.status.color)
            .foregroundColor(.black)
            .cornerRadius(5)
            .font(.title2)
    }
}
