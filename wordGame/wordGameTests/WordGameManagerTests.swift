//
//  WordGameManagerTests.swift
//  wordGameTests
//
//  Created by Felicitas Figueroa Fagalde on 17/08/2023.
//

import Foundation
import XCTest
@testable import wordGame

class WordViewModelTests: XCTestCase {

    var viewModel: WordGameManager!
    var serviceMock: WordServiceMock!
    
    override func setUp() {
        super.setUp()
        serviceMock = WordServiceMock()
        viewModel = WordGameManager(service: serviceMock)
    }

    func testLoadWordsSuccess() {
        // Given
        serviceMock.wordsToReturn = [WordPair(original: "hello", translation: "hola")]
        
        // When
        let result = viewModel.loadWords()
        
        // Then
        switch result {
        case .success(let words):
            XCTAssertEqual(words.count, 1)
            XCTAssertEqual(viewModel.wordPairs.count, 1)
            XCTAssertEqual(viewModel.wordPairs.first?.original, "hello")
            XCTAssertEqual(viewModel.wordPairs.first?.translation, "hola")
        case .failure:
            XCTFail("Expected success but got failure.")
        }
    }

    func testLoadWordsFailure() {
        // Given
        serviceMock.errorToReturn = .resourceNotFound
        
        // When
        let result = viewModel.loadWords()
        
        // Then
        switch result {
        case .success:
            XCTFail("Expected failure but got success.")
        case .failure(let error):
            XCTAssertEqual(error, WordServiceError.resourceNotFound)
        }
    }

    func testSetUnshownIndices() {
        // Given
        serviceMock.wordsToReturn = [WordPair(original: "hello", translation: "hola"), WordPair(original: "world", translation: "mundo")]
        viewModel.loadWords()
        
        // When
        viewModel.setUnshownIndices()
        
        // Then
        XCTAssertEqual(viewModel.unshownIndices, [0, 1])
    }

    func testGetRandomPair() {
        // Given
        serviceMock.wordsToReturn = [WordPair(original: "hello", translation: "hola"), WordPair(original: "world", translation: "mundo")]
        viewModel.loadWords()
        viewModel.setUnshownIndices()
        
        // When
        let pair = viewModel.getRandomPair()
        
        // Then
        XCTAssertNotNil(pair)
        XCTAssert(viewModel.unshownIndices.count == 1)
    }

   
//Test probability of 25%
    func testProbabilityOfCorrectPairManyPairs() {
        testProbabilityOfCorrectPairFor(wordCount: 10000)
    }

    func testProbabilityOfCorrectPairFewPairs() {
        testProbabilityOfCorrectPairFor(wordCount: 3)
    }

    func testProbabilityOfCorrectPair225Pairs() {
        testProbabilityOfCorrectPairFor(wordCount: 225)
    }

    private func testProbabilityOfCorrectPairFor(wordCount: Int) {
        let wordPairs = (1...wordCount).map { WordPair(original: "word\($0)", translation: "palabra\($0)") }
        serviceMock.wordsToReturn = wordPairs
        viewModel.loadWords()
        viewModel.setUnshownIndices()

        let numberOfTries = 10000
        var correctCount = 0
        
        for _ in 0..<numberOfTries {
            let pair = viewModel.getRandomPair()
            if pair?.correct == true {
                correctCount += 1
            }
        }

        let observedProbability = Double(correctCount) / Double(numberOfTries)
        let expectedProbability = 0.25
        let marginOfError = 0.05 // 5% error margin accepted

        XCTAssert(abs(observedProbability - expectedProbability) <= marginOfError, "Observed probability was \(observedProbability) which is outside the margin of error from the expected probability of \(expectedProbability).")
    }

    
    override func tearDown() {
        viewModel = nil
        serviceMock = nil
        super.tearDown()
    }
}
