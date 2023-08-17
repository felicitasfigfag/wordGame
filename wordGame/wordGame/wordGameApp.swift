//
//  wordGameApp.swift
//  wordGame
//
//  Created by Felicitas Figueroa Fagalde on 15/08/2023.
//

import SwiftUI

@main
struct wordGameApp: App {
    @StateObject private var appState = AppState()
    
    private let wordService = WordService()
    private(set) var gameMng: WordGameManager
    private var mainVM: MainViewModel
    
    init() {
        self.gameMng = WordGameManager(service: wordService)
        self.mainVM = MainViewModel(gameMng: self.gameMng)
    }

    var body: some Scene {
        WindowGroup {
            if appState.showingSplash {
                SplashScreen(appState: appState)
            } else if appState.showingInstructions {
                InstructionsView(showInstructions: $appState.showingInstructions)
            } else {
                ContentView(mainVM: mainVM, gameMng: gameMng)
            }
        }
    }
}

class AppState: ObservableObject {
    @Published var showingSplash: Bool = true
    @Published var showingInstructions: Bool = true

    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.showingSplash = false
        }
    }
}
