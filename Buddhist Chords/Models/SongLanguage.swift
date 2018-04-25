//
//  SongLanguage.swift
//  Buddhist Chords
//
//  Created by Viet Nguyen Tran on 4/14/18.
//  Copyright © 2018 iossimple. All rights reserved.
//

import Foundation

enum SongLanguage: Int, CustomStringConvertible {
    case vietnamese = 0
    case english = 1
    case thai = 2
    case unknown = -100
    
    var description: String {
        switch self {
        case .vietnamese:
            return "Tiếng Việt"
        case .english:
            return "English"
        case .thai:
            return "ภาษาไทย"
        case .unknown:
            return "####"
        }
    }
    
    var settingDescription: String {
        switch self {
        case .vietnamese:
            return "🇻🇳 Tiếng Việt"
        case .english:
            return "🇺🇸 English"
        case .thai:
            return "🇹🇭 ภาษาไทย"
        case .unknown:
            return "####"
        }
    }
}

extension SongLanguage: Codable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(self.rawValue)
    }
    
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        if let rawInt = try container.decodeIfPresent(Int.self) {
            self = SongLanguage(rawValue: rawInt) ?? .unknown
        } else {
            self = .unknown
        }
    }
}
