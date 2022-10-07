//
//  FlashcardDeckView.swift
//  Flashcards
//
//  Created by Slave I on 10/6/22.
//

import SwiftUI

struct FlashcardDeckView: View {
    var flashcardDeck: FlashcardDeck
    var body: some View {
        HStack {
            Text(flashcardDeck.title)
                .font(.headline)
            Spacer()
            Text(flashcardDeck.flashcardsCountString())
        }
        .padding()
    }
}

struct FlashcardDeckView_Previews: PreviewProvider {
        
    static var flashcardDeck = FlashcardDeck.sampleData[0]
    static var previews: some View {
        FlashcardDeckView(flashcardDeck: flashcardDeck)
    }
}
