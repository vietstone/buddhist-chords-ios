//
//  RealmConfig.swift
//  Buddhist Chords
//
//  Created by Viet Nguyen Tran on 4/23/18.
//  Copyright © 2018 iossimple. All rights reserved.
//

import Foundation
import RealmSwift

enum RealmConfig {
    private static let mainConfig = Realm.Configuration(
        fileURL: URL.inDocumentsFolder(fileName: "main.realm"),
        schemaVersion: 1
    )
    
    case main
    
    var configuration: Realm.Configuration {
        switch self {
        case .main:
            return RealmConfig.mainConfig
        }
    }
}
