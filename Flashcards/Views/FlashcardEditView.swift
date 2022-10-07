//
//  FlashcardEditView.swift
//  Flashcards
//
//  Created by Slave I on 10/6/22.
//

import SwiftUI

struct FlashcardEditView: View {
    @Binding var cardData: Flashcard.Data
    
    var body: some View {
        Form {
          Section(header: Text("Flashcard Faces")) {
                TextField("Front", text: $cardData.front)
                TextField("Back", text: $cardData.back)
            }
        }
    }
}

struct FlashcardEditView_Previews: PreviewProvider {
    static var previews: some View {
        FlashcardEditView(cardData: .constant(Flashcard.sampleData[0].data))
    }
}
