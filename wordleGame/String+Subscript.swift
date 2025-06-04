//
//  String+Subscript.swift
//  wordleGame
//
//  Created by Fabiana Lozada on 6/2/25.
//
import Foundation

extension String {
    subscript(i: Int) -> Character {
        self[index(startIndex, offsetBy: i)]
    }
}
