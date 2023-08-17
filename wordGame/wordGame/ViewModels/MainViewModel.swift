//
//  MainViewModel.swift
//  wordGame
//
//  Created by Felicitas Figueroa Fagalde on 15/08/2023.
//

import Foundation
import SwiftUI


class MainViewModel : ObservableObject {
    
    var gameMng: WordGameManager
    var alertManager = AlertManager()
    
    ///Attempts
    @Published var correctAttempts: Int = 0
    @Published var wrongAttempts: Int = 0
    
    ///Pair
    @Published var originalWord: String = "This is an English word"
    @Published var translatedWord: String = "This is a random Spanish translation"
    
    @Published var shownPair : WordPair = WordPair(original: "", translation: ""){
        didSet{
            originalWord = shownPair.original
            translatedWord = shownPair.translation}
    }
    ///Alerts
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    @Published var endGameAlert: CustomAlert?
    @Published var showByeView = false 
    
    private var timer: Timer?
    
    init(gameMng: WordGameManager) {
        self.gameMng = gameMng
        setupAttemptsFromUserDefaults()
        
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
        timer?.invalidate()
        guard let randomPair = gameMng.getRandomPair() else {
            return
        }
        self.shownPair = randomPair
        startTimer()
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
    
    func closeApp(){
        UserDefaults.standard.synchronize()
        exit(0) 
    }
    func showByeScreenAndCloseApp() {
        self.showByeView = true
        UserDefaults.standard.synchronize()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            exit(0)
        }
    }
}


//Attempts
extension MainViewModel {
    
    func updateAttempts(selection: Bool) {
        incrementAttempts(isCorrect: selection == shownPair.correct)
        updateAttemptsInUserDefaults()

        guard shouldContinueGame() else { return }

        setShownPair()
    }

    func incrementAttempts(isCorrect: Bool) {
        if isCorrect {
            self.correctAttempts += 1
        } else {
            self.wrongAttempts += 1
        }
    }


    func updateAttemptsInUserDefaults() {
        UserDefaultsManager.shared.set(self.correctAttempts, for: .correctAttempts)
        UserDefaultsManager.shared.set(self.wrongAttempts, for: .wrongAttempts)
    }

    private func setupAttemptsFromUserDefaults() {
        self.correctAttempts = UserDefaultsManager.shared.get(.correctAttempts) ?? 0
        self.wrongAttempts = UserDefaultsManager.shared.get(.wrongAttempts) ?? 0
    }
      
    private func resetAttemptsInUserDefaults() {
        UserDefaultsManager.shared.set(0, for: .correctAttempts)
        UserDefaultsManager.shared.set(0, for: .wrongAttempts)
    }
    
}


//Alerts
extension MainViewModel {

    func displayError(_ message: String) {
        self.alertManager.alert = Alert(title: Text("Error"), message: Text(message), dismissButton: .default(Text("Ok")))
        self.alertManager.showAlert = true
    }

}

//Game ending

extension MainViewModel {
    
    func handleGameWin() {
        print("you won")
        timer?.invalidate()
        resetAttemptsInUserDefaults()
        endGameAlert = CustomAlert(title: "Congratulations", message: "You won!", buttonText: "Close app")
    }

    func handleGameOver() {
        print("game over")
        timer?.invalidate()
        resetAttemptsInUserDefaults()
        endGameAlert = CustomAlert(title: "Game Over", message: "Better luck next time!", buttonText: "Close app")
    }

    func shouldContinueGame() -> Bool {
        if self.wrongAttempts == 3 {
            handleGameOver()
            return false
        }
        
        if (correctAttempts + wrongAttempts) == 15 {
            handleGameWin()
            return false
        }
        
        return true
    }

}
