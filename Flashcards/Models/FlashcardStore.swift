//
//  FlashcardStore.swift
//  Flashcards
//
//  Created by Slave I on 10/6/22.
//

import Foundation
import SwiftUI

class FlashcardStore: ObservableObject {
    @Published var flashcardDecks: [FlashcardDeck] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("flashcards.data")
    }
    
    static func load(completion: @escaping (Result<[FlashcardDeck], Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                let flashcardDecks = try JSONDecoder().decode([FlashcardDeck].self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(flashcardDecks))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    static func save(flashcardDecks: [FlashcardDeck], completion: @escaping (Result<Int, Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(flashcardDecks)
                let outfile = try fileURL()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(flashcardDecks.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
