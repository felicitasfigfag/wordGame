//
//  UserDefaultsManager.swift
//  wordGame
//
//  Created by Felicitas Figueroa Fagalde on 17/08/2023.
//

import Foundation

class UserDefaultsManager {
    static let shared = UserDefaultsManager()

    enum Key: String {
        case correctAttempts = "CorrectAttempts"
        case wrongAttempts = "WrongAttempts"
        case unshownIndices = "UnshownIndices"
    }
    
    func get<T>(_ key: Key) -> T? {
        return UserDefaults.standard.object(forKey: key.rawValue) as? T
    }

    func set<T>(_ value: T, for key: Key) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    func resetAttempts() {
        set(0, for: .correctAttempts)
        set(0, for: .wrongAttempts)
    }
}
