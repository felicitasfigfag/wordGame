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
    
    func set<T>(_ value: T, for key: Key) {
        if key != .unshownIndices {
            print("USER DEFAULTS: Setting \(key.rawValue): \(value)")
        }
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }

    func get<T>(_ key: Key) -> T? {
        if let value = UserDefaults.standard.object(forKey: key.rawValue) as? T {
            if key != .unshownIndices {
                print("USER DEFAULTS: Getting \(key.rawValue): \(value)")
            }
            return value
        }
        return nil
    }


    
    func resetAttempts() {
        set(0, for: .correctAttempts)
        set(0, for: .wrongAttempts)
    }
}
