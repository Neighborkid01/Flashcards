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

struct Flashcard: Identifiable, Codable {
    let id: UUID
    var front: String
    var back: String
    var state = FlashcardState.front
    
    init(id: UUID = UUID(), front: String, back: String) {
        self.id = id
        self.front = front
        self.back = back
    }
    
    init(id: UUID = UUID(), data: Flashcard.Data) {
        self.id = id
        self.front = data.front
        self.back = data.back
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
    struct Data {
        var front: String = ""
        var back: String = ""
    }
    
    var data: Data {
        Data(front: front, back: back)
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
