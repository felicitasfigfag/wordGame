//
//  WordServiceMock.swift
//  wordGame
//
//  Created by Felicitas Figueroa Fagalde on 17/08/2023.
//

import Foundation
class WordServiceMock: WordServiceProtocol {
    
    var wordsToReturn: [WordPair] = []
    var errorToReturn: WordServiceError?

    func loadWordData() -> Result<[WordPair], WordServiceError> {
        if let error = errorToReturn {
            return .failure(error)
        }
        return .success(wordsToReturn)
    }
}
