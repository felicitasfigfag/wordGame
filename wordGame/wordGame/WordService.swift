//
//  WordService.swift
//  wordGame
//
//  Created by Felicitas Figueroa Fagalde on 15/08/2023.
//

import Foundation

class WordService {
    
    func loadWordData() -> Result<[WordPair], WordServiceError> {
        if let url = Bundle.main.url(forResource: "words", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let words = try decoder.decode([WordPair].self, from: data)
                return .success(words)
            } catch {
                return .failure(.decodingError(error))
            }
        }
        return .failure(.resourceNotFound)
    }

}
