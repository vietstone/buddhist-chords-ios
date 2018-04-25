//
//  User.swift
//  Buddhist Chords
//
//  Created by Viet Nguyen Tran on 4/25/18.
//  Copyright © 2018 iossimple. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    // MARK: - Init
    convenience init(name: String) {
        self.init()
        self.name = name
    }
    
    // MARK: - Properties
    @objc dynamic var name = ""
    let list = List<SongResponse>()
    
    // MARK: - Meta
    override static func primaryKey() -> String? {
        return "name"
    }
    
    // MARK: - Etc
    private static func createDefaultUser(in realm: Realm) -> User {
        let me = User(name: "me")
        try! realm.write {
            realm.add(me)
        }
        return me
    }
    
    @discardableResult
    static func defaultUser(in realm: Realm) -> User {
        return realm.object(ofType: User.self, forPrimaryKey: "me")
            ?? createDefaultUser(in: realm)
    }
}
