//
//  MainViewModelTests.swift
//  wordGameTests
//
//  Created by Felicitas Figueroa Fagalde on 17/08/2023.
//

import Foundation
import XCTest
import SwiftUI
@testable import wordGame

class MainViewModelTests: XCTestCase {
    
    var viewModel: MainViewModel!
    var gameManagerMock: WordGameManagerMock!
    
    override func setUp() {
        super.setUp()
        gameManagerMock = WordGameManagerMock()
        viewModel = MainViewModel(gameMng: gameManagerMock)
    }

    func testSetupGameSuccess() {
        gameManagerMock.loadWordsResult = .success([WordPair(original: "test", translation: "prueba")])
        
        viewModel.setupGame()
        
        XCTAssertEqual(viewModel.shownPair.original, "test")
        XCTAssertEqual(viewModel.shownPair.translation, "prueba")
    }
    

    func testCorrectAttemptUpdate() {
        viewModel.shownPair = WordPair(original: "test", translation: "prueba", correct: true)
        
        viewModel.handleUserSelection(selection: true)
        
        XCTAssertEqual(viewModel.correctAttempts, 1)
    }

    func testIncorrectAttemptUpdate() {
        viewModel.shownPair = WordPair(original: "test", translation: "prueba", correct: false)
        
        viewModel.handleUserSelection(selection: true)
        
        XCTAssertEqual(viewModel.wrongAttempts, 1)
    }

    func testWinningCondition() {
        viewModel.correctAttempts = 14
        viewModel.shownPair = WordPair(original: "test", translation: "prueba", correct: true)
        
        viewModel.handleUserSelection(selection: true)
        
        XCTAssertNotNil(viewModel.endGameAlert)
        XCTAssertEqual(viewModel.endGameAlert?.title, "Congratulations")
        XCTAssertEqual(viewModel.endGameAlert?.message, "You won!")
    }

    func testLosingCondition() {
        viewModel.wrongAttempts = 2
        viewModel.shownPair = WordPair(original: "test", translation: "prueba", correct: false)
        
        viewModel.handleUserSelection(selection: true)
        
        XCTAssertNotNil(viewModel.endGameAlert)
        XCTAssertEqual(viewModel.endGameAlert?.title, "Game Over")
        XCTAssertEqual(viewModel.endGameAlert?.message, "Better luck next time!")
    }

    override func tearDown() {
        viewModel = nil
        gameManagerMock = nil
        super.tearDown()
    }
}
