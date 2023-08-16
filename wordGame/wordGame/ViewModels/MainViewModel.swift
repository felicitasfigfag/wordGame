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
    private var timer: Timer?
    @Published var shownPair : WordPair = WordPair(original: "", translation: ""){
        didSet{
            originalWord = shownPair.original
            translatedWord = shownPair.translation
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
        startTimer()
    }
    
    
    
    func updateAttempts(selection: Bool){
        if selection == shownPair.correct {
            self.correctAttempts += 1
        } else {
            self.wrongAttempts += 1
        }
    }
    
    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { [weak self] _ in
               guard let oppositeValue = self?.shownPair.correct?.toggleValue else { return }
               self?.handleUserSelection(selection: oppositeValue)
           }
       }

    
    func handleUserSelection(selection: Bool) {
        updateAttempts(selection: selection)
        
        if correctAttempts >= 15 {
            print("¡Has ganado!")
            timer?.invalidate()
            
        } else if wrongAttempts >= 3 {
            print("Game Over")
            timer?.invalidate()
            
        } else {
            setShownPair()
        }
    }

}
