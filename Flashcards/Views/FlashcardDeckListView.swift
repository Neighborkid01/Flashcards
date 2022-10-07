//
//  FlashcardListView.swift
//  Flashcards
//
//  Created by Slave I on 10/6/22.
//

import SwiftUI

struct FlashcardDeckListView: View {
    @Binding var flashcardDecks: [FlashcardDeck]
    @State private var isPresentingNewDeckView = false
    @State private var newDeckData = FlashcardDeck.Data()
    
    @Environment(\.scenePhase) private var scenePhase
    let saveAction: ()->Void
    
    var body: some View {
        List {
            ForEach($flashcardDecks) { $flashcardDeck in
                NavigationLink(destination: FlashcardView(flashcardDeck: $flashcardDeck)) {
                    FlashcardDeckView(flashcardDeck: flashcardDeck)
                }
            }
            .onDelete { indices in
                flashcardDecks.remove(atOffsets: indices)
            }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
        .navigationTitle("Flashcard Decks")
        .toolbar {
            Button(action: {
                isPresentingNewDeckView = true
            }) {
                Image(systemName: "plus")
            }
        }
        .sheet(isPresented: $isPresentingNewDeckView) {
            NavigationView {
                FlashcardDeckEditView(data: $newDeckData)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Dismiss") {
                                isPresentingNewDeckView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Add") {
                                let newDeck = FlashcardDeck(data: newDeckData)
                                flashcardDecks.append(newDeck)
                                saveAction()
                                isPresentingNewDeckView = false
                                newDeckData = FlashcardDeck.Data()
                            }
                        }
                    }
            }
        }
    }
}

struct FlashcardListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FlashcardDeckListView(flashcardDecks: .constant(FlashcardDeck.sampleData), saveAction: {})
        }
    }
}
