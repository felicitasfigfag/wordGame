//
//  Models.swift
//  wordGame
//
//  Created by Felicitas Figueroa Fagalde on 15/08/2023.
//

import Foundation

struct WordPair: Codable {
    var eng: String
    var spa: String
    var correct: Bool?

    enum CodingKeys: String, CodingKey {
        case eng = "text_eng"
        case spa = "text_spa"
    }
}

struct WordList: Codable {
    var words: [WordPair]
}
