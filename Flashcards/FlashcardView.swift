//
//  FlashcardView.swift
//  Flashcards
//
//  Created by Slave I on 10/6/22.
//

import SwiftUI

struct FlashcardView: View {
    @Binding var flashcards: [Flashcard]
    @Environment(\.scenePhase) private var scenePhase
    let saveAction: ()->Void
    
    @State private var flashcard = Flashcard(front: "Hola", back: "Hello")
    var index = 0
    var body: some View {
        ZStack {
            flashcard.backgroundColorForCurrentFace().ignoresSafeArea()
            VStack {
                Text(flashcard.textForCurrentFace())
                    .frame(width: 400, height: 400)
                    .foregroundColor(flashcard.textColorForCurrentFace())
            }
            .contentShape(Rectangle())
            .padding()
            .onTapGesture {
                flashcard.toggleState()
            }
            .onChange(of: scenePhase) { phase in
                if phase == .inactive { saveAction() }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FlashcardView(flashcards: .constant(Flashcard.sampleData), saveAction: {})
    }
}
