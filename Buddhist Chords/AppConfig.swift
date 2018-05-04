//
//  AppConfig.swift
//  Buddhist Chords
//
//  Created by Viet Nguyen Tran on 4/9/18.
//  Copyright © 2018 iossimple. All rights reserved.
//

import Foundation

final class AppConfig {
    static let appLanguages: [SongLanguage] = [.all, .vietnamese, .english, .thai]
    static let languageUserDefaultsSettingKey = "language"
}
