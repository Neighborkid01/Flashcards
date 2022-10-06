//
//  FlashcardStore.swift
//  Flashcards
//
//  Created by Slave I on 10/6/22.
//

import Foundation
import SwiftUI

class FlashcardStore: ObservableObject {
    @Published var flashcards: [Flashcard] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("flashcards.data")
    }
    
    static func load(completion: @escaping (Result<[Flashcard], Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                let flashcards = try JSONDecoder().decode([Flashcard].self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(flashcards))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    static func save(flashcards: [Flashcard], completion: @escaping (Result<Int, Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(flashcards)
                let outfile = try fileURL()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(flashcards.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
