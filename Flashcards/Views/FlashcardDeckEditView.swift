//
//  FlashcardDeckEditView.swift
//  Flashcards
//
//  Created by Slave I on 10/6/22.
//

import SwiftUI

struct FlashcardDeckEditView: View {
    @Binding var data: FlashcardDeck.Data
    @State private var newFlashcardData = Flashcard.Data()
    
    var body: some View {
        Form {
            Section(header: Text("Deck Info")) {
                TextField("Title", text: $data.title)
            }
            Section(header: Text("Flashcards")) {
                ForEach(data.flashcards) { flashcard in
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Front:")
                                .foregroundColor(.gray)
                            Text(flashcard.front)
                        }
                        HStack {
                            Text("Back:")
                                .foregroundColor(.gray)
                            Text(flashcard.back)
                        }
                    }
                }
                .onDelete { indices in
                    data.flashcards.remove(atOffsets: indices)
                }
                HStack {
                    VStack {
                        TextField("Front", text: $newFlashcardData.front)
                        TextField("Back", text: $newFlashcardData.back)
                    }
                    Button(action: {
                        withAnimation {
                            let flashcard = Flashcard(data: newFlashcardData)
                            data.flashcards.append(flashcard)
                            newFlashcardData = Flashcard.Data()
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                    }

                }
            }
        }
    }
}

struct FlashcardDeckEditView_Previews: PreviewProvider {
    static var previews: some View {
        FlashcardDeckEditView(data: .constant(FlashcardDeck.sampleData[0].data))
    }
}
