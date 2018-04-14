//
//  Song.swift
//  Buddhist Chords
//
//  Created by Viet Nguyen Tran on 4/9/18.
//  Copyright © 2018 iossimple. All rights reserved.
//

import Foundation

struct Song: Codable {
    var id: Int?
    var title: String?
    var language: SongLanguage? = .vietnamese
    var body: String? = "<html></html>"
}
