//
//  FlashcardsApp.swift
//  Flashcards
//
//  Created by Slave I on 10/6/22.
//

import SwiftUI

@main
struct FlashcardsApp: App {
    @StateObject private var store = FlashcardStore()
    var body: some Scene {
        WindowGroup {
            FlashcardView(flashcards: $store.flashcards) {
                FlashcardStore.save(flashcards: store.flashcards) { result in
                    if case .failure(let error) = result {
                        fatalError(error.localizedDescription)
                    }
                }
            }
            .onAppear {
                FlashcardStore.load { result in
                    switch result {
                    case .failure(let error):
                        fatalError(error.localizedDescription)
                    case .success(let flashcards):
                        store.flashcards = flashcards
                    }
                }
            }
        }
    }
}
