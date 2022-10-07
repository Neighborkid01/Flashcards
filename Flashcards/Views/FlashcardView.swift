//
//  FlashcardView.swift
//  Flashcards
//
//  Created by Slave I on 10/6/22.
//

import SwiftUI

struct FlashcardView: View {
    @Binding var flashcardDeck: FlashcardDeck
    
    @State private var deckData = FlashcardDeck.Data()
    @State private var cardData = Flashcard.Data()
    @State private var isPresentingEditView = false
    @State private var index = 0

    var body: some View {
        ZStack {
            flashcardDeck.flashcards[index].backgroundColorForCurrentFace().ignoresSafeArea()
            VStack {
                Text(flashcardDeck.flashcards[index].textForCurrentFace())
                    .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
                    .font(.system(size: 40))
                    .foregroundColor(flashcardDeck.flashcards[index].textColorForCurrentFace())

            }
            .contentShape(Rectangle())
            .padding()
            .onTapGesture {
                flashcardDeck.flashcards[index].toggleState()
            }
        }
        .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
            .onEnded({ value in
                print(value.translation)
                if value.translation.width < 0 {
                    index += 1
                    if index >= flashcardDeck.flashcards.count { index = flashcardDeck.flashcards.count - 1 }
                }
                if value.translation.width > 0 {
                    index -= 1
                    if index < 0 { index = 0 }
                }
            }))
        .toolbar {
            Button("Edit") {
                isPresentingEditView = true
                deckData = flashcardDeck.data
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
            NavigationView {
                FlashcardDeckEditView(data: $deckData)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                flashcardDeck.title = deckData.title
                                flashcardDeck.flashcards = deckData.flashcards
                                isPresentingEditView = false
                            }
                        }
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FlashcardView(flashcardDeck: .constant(FlashcardDeck.sampleData[0]))
    }
}
