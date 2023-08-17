//
//  MainViewModel.swift
//  wordGame
//
//  Created by Felicitas Figueroa Fagalde on 15/08/2023.
//

import Foundation
import SwiftUI

class AlertManager: ObservableObject {
    @Published var showAlert: Bool = false
    var alert: Alert!
}


class MainViewModel : ObservableObject {
    
    var gameMng: WordGameManager
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
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    private let correctAttemptsKey = "CorrectAttempts"
    private let wrongAttemptsKey = "WrongAttempts"
    
    var alertManager = AlertManager()
    @Published var endGameAlert: CustomAlert? {
        didSet{
            print("Set end game alert: ", endGameAlert?.title)
        }
    }

    
    init(gameMng: WordGameManager) {
        self.gameMng = gameMng
        setupAttemptsFromUserDefaults()
        setupGame()
    }
    
    func setupGame() {
        let result = gameMng.loadWords()
        switch result {
        case .success:
            setShownPair()
        case .failure(let error):
            handleLoadingError(error: error)
        }
    }

    func setShownPair(){
        guard let randomPair = gameMng.getRandomPair() else {
            return
        }
        self.shownPair = randomPair
    }
    
    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { [weak self] _ in
               guard let oppositeValue = self?.shownPair.correct?.toggleValue else { return }
               self?.handleUserSelection(selection: oppositeValue)
           }
       }
       
    func handleUserSelection(selection: Bool) {
           if (correctAttempts + wrongAttempts) == 15 {
               print("you won")
               timer?.invalidate()
               resetAttemptsInUserDefaults()
               endGameAlert = CustomAlert(title: "Congratulations", message: "You won!", buttonText: "Close app")
               
               
           } else if wrongAttempts == 3 {
               print("game over")
               timer?.invalidate()
               resetAttemptsInUserDefaults()
               endGameAlert = CustomAlert(title: "Game Over", message: "Better luck next time!", buttonText: "Close app")
               
           } else {
               updateAttempts(selection: selection)
               UserDefaultsManager.shared.set(correctAttempts, for: .correctAttempts)
               UserDefaultsManager.shared.set(wrongAttempts, for: .wrongAttempts)
               setShownPair()
           }
       }
    
    func handleLoadingError(error: WordServiceError) {
        switch error {
        case .decodingError(let decodingError):
            displayError("Decoding error: \(decodingError.localizedDescription)")
        case .resourceNotFound:
            displayError("Resource not found.")
        case .dataLoadError:
            displayError("Data loading error.")
        }
    }
}


//Attempts
extension MainViewModel {
    private func setupAttemptsFromUserDefaults() {
        self.correctAttempts = UserDefaultsManager.shared.get(.correctAttempts) ?? 0
        self.wrongAttempts = UserDefaultsManager.shared.get(.wrongAttempts) ?? 0
    }
      
    private func resetAttemptsInUserDefaults() {
        UserDefaultsManager.shared.set(0, for: .correctAttempts)
        UserDefaultsManager.shared.set(0, for: .wrongAttempts)
    }
    
    func updateAttempts(selection: Bool){
        if selection == shownPair.correct {
            self.correctAttempts += 1
        } else {
            self.wrongAttempts += 1
        }
    }
}


//Alerts
extension MainViewModel {

    func displayError(_ message: String) {
        self.alertManager.alert = Alert(title: Text("Error"), message: Text(message), dismissButton: .default(Text("Ok")))
        self.alertManager.showAlert = true
    }

}
