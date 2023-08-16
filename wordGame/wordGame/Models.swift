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
