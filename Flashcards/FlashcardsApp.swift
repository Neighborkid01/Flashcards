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
            NavigationView {
                FlashcardDeckListView(flashcardDecks: $store.flashcardDecks) {
                    FlashcardStore.save(flashcardDecks: store.flashcardDecks) { result in
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
                        case .success(let flashcardDecks):
                            store.flashcardDecks = flashcardDecks
                        }
                    }
                }
            }
        }
    }
}

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}
