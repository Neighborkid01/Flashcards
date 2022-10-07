//
//  FlashcardDeck.swift
//  Flashcards
//
//  Created by Slave I on 10/6/22.
//

import Foundation

struct FlashcardDeck: Identifiable, Codable {
    let id: UUID
    var title: String
    var flashcards: [Flashcard]
    
    init(id: UUID = UUID(), title: String, flashcards: [Flashcard]) {
        self.id = id
        self.title = title
        self.flashcards = flashcards
    }
    
    init(id: UUID = UUID(), data: FlashcardDeck.Data) {
        self.id = id
        self.title = data.title
        self.flashcards = data.flashcards
    }
    
    func flashcardsCountString() -> String {
        let units = flashcards.count == 1 ? "card" : "cards"
        return "\(flashcards.count) \(units)"
    }
}

extension FlashcardDeck {
    struct Data {
        var title: String = ""
        var flashcards: [Flashcard] = []
    }
    
    var data: Data {
        Data(title: title, flashcards: flashcards)
    }
}

extension FlashcardDeck {
    static let sampleData = [
        FlashcardDeck(title: "English", flashcards: Flashcard.sampleData),
        FlashcardDeck(title: "Spanish", flashcards: [Flashcard.sampleData[0]]),
    ]
}
