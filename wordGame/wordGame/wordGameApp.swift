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
    private(set) var wordVM: WordViewModel
    private var mainVM: MainViewModel

    init() {
        self.wordVM = WordViewModel(service: wordService)
        self.mainVM = MainViewModel(wordVM: self.wordVM)
        
    }

    var body: some Scene {
        WindowGroup {
            ContentView(mainVM: mainVM, wordVM: wordVM)
        }
    }
}
