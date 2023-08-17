//
//  WordsViewModel.swift
//  wordGame
//
//  Created by Felicitas Figueroa Fagalde on 15/08/2023.
//

import Foundation

class WordGameManager {
    private var wordService: WordServiceProtocol
    var wordPairs: [WordPair] = []
    var unshownIndices: [Int] = []
    
    init(service: WordServiceProtocol) {
        self.wordService = service
        loadWords()
        setUnshownIndices()
    }
    
 
    
    //Get data from service
    func loadWords() -> Result<[WordPair], WordServiceError> {
        let result = wordService.loadWordData()
        switch result {
        case .success(let words):
            self.wordPairs = words
            return .success(words)
        case .failure(let error):
            return .failure(error)
        }
    }

    
    func setUnshownIndices(){
        self.unshownIndices = Array(0..<wordPairs.count)
    }
    
    func getRandomPair() -> WordPair? {
        if unshownIndices.isEmpty {
            setUnshownIndices()
            // Check if unshownIndices is still empty after attempting to set it
            if unshownIndices.isEmpty {
                return nil
            }
        }

        let randomPosition = Int.random(in: 0..<unshownIndices.count)
        let randomIndex = unshownIndices[randomPosition]
        unshownIndices.remove(at: randomPosition)
        
        // Decide if the pair will be shown as correct or incorrect
        let isCorrect = Double.random(in: 0...1) <= 0.25
        guard randomIndex < wordPairs.count else { return nil }
        var selectedPair = wordPairs[randomIndex]
        
        if isCorrect {
            selectedPair.correct = true
            return selectedPair
        } else {
            // Make sure wordPairs is not empty before getting a random index
            guard !wordPairs.isEmpty else { return nil }
            let incorrectTranslatedIndex = Int.random(in: 0..<wordPairs.count)
            selectedPair.translation = wordPairs[incorrectTranslatedIndex].translation
            selectedPair.correct = false
            return selectedPair
        }
    }


    
}

