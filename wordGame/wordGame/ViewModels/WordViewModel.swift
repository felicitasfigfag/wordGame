//
//  WordsViewModel.swift
//  wordGame
//
//  Created by Felicitas Figueroa Fagalde on 15/08/2023.
//

import Foundation

class WordViewModel {
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
        }

        let randomPosition = Int.random(in: 0..<unshownIndices.count)
        let randomIndex = unshownIndices[randomPosition]
        unshownIndices.remove(at: randomPosition)
        
        // Decide if the pair will be shown as correct or incorrect
        let isCorrect = Double.random(in: 0...1) <= 0.25
        
        var selectedPair = wordPairs[randomIndex]
        
        if isCorrect {
            selectedPair.correct = true
            return selectedPair
        } else {
            // Choose a random translated word for incorrect pairing
            let incorrectTranslatedIndex = Int.random(in: 0..<wordPairs.count)
            selectedPair.translation = wordPairs[incorrectTranslatedIndex].translation
            selectedPair.correct = false
            return selectedPair
        }
    }

    
}

