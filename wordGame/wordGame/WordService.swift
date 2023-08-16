//
//  WordService.swift
//  wordGame
//
//  Created by Felicitas Figueroa Fagalde on 15/08/2023.
//

import Foundation

class WordService {
    func loadWordData() -> [WordPair]? {
        print("Service activated")
        if let url = Bundle.main.url(forResource: "words", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let words = try decoder.decode([WordPair].self, from: data)
                return words
            } catch {
                print("Error loading or parsing JSON:", error)
            }
        }
        return nil
    }
}
