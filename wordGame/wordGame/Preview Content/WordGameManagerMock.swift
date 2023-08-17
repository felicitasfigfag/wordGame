//
//  MainViewModelTests.swift
//  wordGame
//
//  Created by Felicitas Figueroa Fagalde on 17/08/2023.
//

import Foundation
class WordGameManagerMock: WordGameManager {

    var loadWordsResult: Result<[WordPair], WordServiceError> = .success([])
    var randomPairToReturn: WordPair?

    init() {
        let mockService = WordServiceMock()
        super.init(service: mockService)
    }
    
    override func loadWords() -> Result<[WordPair], WordServiceError> {
        if case .success(let words) = loadWordsResult {
            self.wordPairs = words
        }
        return loadWordsResult
    }
    
    override func getRandomPair() -> WordPair? {
        if let pair = randomPairToReturn {
            return pair
        } else {
            return super.getRandomPair()
        }
    }
}
