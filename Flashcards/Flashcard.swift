//
//  Flashcard.swift
//  Flashcards
//
//  Created by Slave I on 10/6/22.
//

import Foundation
import SwiftUI

enum FlashcardState: Codable {
    case front
    case back
}

struct Flashcard: Codable {
    var front: String
    var back: String
    var state = FlashcardState.front
    
    init(front: String, back: String) {
        self.front = front
        self.back = back
    }
    
    func textForCurrentFace() -> String {
        return state == .front ? front : back
    }
    
    func textColorForCurrentFace() -> Color {
        return state == .front ? .black : .white
    }
    
    func backgroundColorForCurrentFace() -> Color {
        return state == .front ? .white : .black
    }
    
    mutating func toggleState() {
        state = (state == .front) ? .back : .front
    }
    
    mutating func setState(newState: FlashcardState) {
        state = newState
    }
}

extension Flashcard {
    static let sampleData: [Flashcard] =
        [
            Flashcard(front: "Hola", back: "Hello"),
            Flashcard(front: "Buenos días", back: "Good morning"),
            Flashcard(front: "Buenas tardes", back: "Good afternoon"),
            Flashcard(front: "Buenas noches", back: "Good evening"),
        ]
}
