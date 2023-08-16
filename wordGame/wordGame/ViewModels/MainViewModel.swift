//
//  MainViewModel.swift
//  wordGame
//
//  Created by Felicitas Figueroa Fagalde on 15/08/2023.
//

import Foundation

class MainViewModel : ObservableObject {
    var wordVM: WordViewModel
    @Published var correctAttempts: Int = 0
    @Published var wrongAttempts: Int = 0
    @Published var originalWord: String = "This is an English word"
    @Published var translatedWord: String = "This is a random Spanish translation"
    @Published var shownPair : WordPair = WordPair(eng: "", spa: ""){
        didSet{
            originalWord = shownPair.eng
            translatedWord = shownPair.spa
        }
    }
    
    init(wordVM: WordViewModel){
        self.wordVM = wordVM
        setShownPair()
        
    }
    
    func setShownPair(){
        guard let randomPair = wordVM.getRandomPair() else {
            return
        }
        self.shownPair = randomPair
    }
    
    func correctButton(correct: Bool){
        if correct == shownPair.correct {
            print("Shown pair is: ", shownPair)
            print("User said it is: ",correct)
            print("Pair is actually: ", shownPair.correct)
            self.correctAttempts += 1
            print("Correct attempts: ", correctAttempts)
        } else {
            self.wrongAttempts += 1
            print("Wrong attempts: ", wrongAttempts)
        }
    }
}
