//
//  Models.swift
//  wordGame
//
//  Created by Felicitas Figueroa Fagalde on 15/08/2023.
//

import Foundation

struct WordPair: Codable {
    var original: String
    var translation: String
    var correct: Bool?

    enum CodingKeys: String, CodingKey {
        case original = "text_eng"
        case translation = "text_spa"
    }
}

struct WordList: Codable {
    var words: [WordPair]
}

extension Bool {
    var toggleValue: Bool {
        return !self
    }
}

enum WordServiceError: Error, Equatable {
    case resourceNotFound
    case dataLoadError
    case decodingError(Error)
    
    static func == (lhs: WordServiceError, rhs: WordServiceError) -> Bool {
        switch (lhs, rhs) {
        case (.resourceNotFound, .resourceNotFound),
             (.dataLoadError, .dataLoadError):
            return true
        case (.decodingError, .decodingError): 
            return true
        default:
            return false
        }
    }
}

struct CustomAlert: Identifiable {
    var id = UUID() // Para conformar al protocolo Identifiable
    var title: String
    var message: String
    var buttonText: String
    var action: (() -> Void)?
}
