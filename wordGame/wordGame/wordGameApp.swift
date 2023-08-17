//
//  wordGameApp.swift
//  wordGame
//
//  Created by Felicitas Figueroa Fagalde on 15/08/2023.
//

import SwiftUI

@main
struct wordGameApp: App {
    private let wordService = WordService()
    private(set) var gameMng: WordGameManager
    private var mainVM: MainViewModel

    init() {
        self.gameMng = WordGameManager(service: wordService)
        self.mainVM = MainViewModel(gameMng: self.gameMng)
        
    }

    var body: some Scene {
        WindowGroup {
            ContentView(mainVM: mainVM, gameMng: gameMng)
        }
    }
}
