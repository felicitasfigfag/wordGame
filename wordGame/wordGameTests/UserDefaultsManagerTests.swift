//
//  UserDefaultsManagerTests.swift
//  wordGameTests
//
//  Created by Felicitas Figueroa Fagalde on 17/08/2023.
//

import XCTest
@testable import wordGame

class UserDefaultsManagerTests: XCTestCase {
    
    let userDefaultsManager = UserDefaultsManager.shared
    
    override func setUp() {
        super.setUp()
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
    }
    
    override func tearDown() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        super.tearDown()
    }
    
    func testCorrectAttemptsPersistence() {
        let attempts: Int = 5
        userDefaultsManager.set(attempts, for: .correctAttempts)
        
        let savedAttempts: Int? = userDefaultsManager.get(.correctAttempts)
        XCTAssertEqual(savedAttempts, attempts, "Correct attempts did not persist correctly.")
    }
    
    func testWrongAttemptsPersistence() {
        let attempts: Int = 3
        userDefaultsManager.set(attempts, for: .wrongAttempts)
        
        let savedAttempts: Int? = userDefaultsManager.get(.wrongAttempts)
        XCTAssertEqual(savedAttempts, attempts, "Wrong attempts did not persist correctly.")
    }
    
    func testResetAttempts() {
        userDefaultsManager.set(5, for: .correctAttempts)
        userDefaultsManager.set(3, for: .wrongAttempts)
        userDefaultsManager.resetAttempts()
        
        let savedCorrectAttempts: Int? = userDefaultsManager.get(.correctAttempts)
        let savedWrongAttempts: Int? = userDefaultsManager.get(.wrongAttempts)
        
        XCTAssertEqual(savedCorrectAttempts, 0, "Correct attempts did not reset correctly.")
        XCTAssertEqual(savedWrongAttempts, 0, "Wrong attempts did not reset correctly.")
    }
    
 
}
