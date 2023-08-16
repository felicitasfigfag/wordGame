//
//  WordsViewModel.swift
//  wordGame
//
//  Created by Felicitas Figueroa Fagalde on 15/08/2023.
//

import Foundation

class WordViewModel {
    private var wordService: WordService
    var wordPairs: [WordPair] = []{
        didSet{
            print("Word pairs are: ", self.wordPairs.count)
        }
    }
    var unshownIndices: [Int] = []
    
    init(service: WordService) {
        self.wordService = service
        loadWords()
        self.unshownIndices = Array(0..<wordPairs.count)
    }
    
    //Get data from service
    private func loadWords() {
        if let loadedWords = wordService.loadWordData() {
            self.wordPairs = loadedWords
        }
    }
    
    

    func getRandomPair() -> WordPair? {
        guard !unshownIndices.isEmpty else { return nil }

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
            // Choose a random Spanish word for incorrect pairing
            let incorrectSpanishIndex = Int.random(in: 0..<wordPairs.count)
            selectedPair.spa = wordPairs[incorrectSpanishIndex].spa
            selectedPair.correct = false
            return selectedPair
        }
    }


    
    
}

