//
//  SongLanguage.swift
//  Buddhist Chords
//
//  Created by Viet Nguyen Tran on 4/14/18.
//  Copyright © 2018 iossimple. All rights reserved.
//

import Foundation

enum SongLanguage: String, CustomStringConvertible {
    case vietnamese = "vietnamese"
    case english = "english"
    case unknown = "####"
    
    var description: String {
        return self.rawValue
    }
}

extension SongLanguage: Codable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(self.rawValue)
    }
    
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        if let rawString = try container.decodeIfPresent(String.self) {
            self = SongLanguage(rawValue: rawString) ?? .unknown
        } else {
            self = .unknown
        }
    }
}
