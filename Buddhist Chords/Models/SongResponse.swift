/* 
Copyright (c) 2018 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

//
//  SongResponse.swift
//  Buddhist Chords
//
//  Created by Viet Nguyen Tran on 4/23/18.
//  Copyright © 2018 iossimple. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

private let UnknownID = -100

class SongResponse : Object, Decodable {
	@objc dynamic var id : Int = UnknownID
    @objc dynamic var tieude : String?
    @objc dynamic var loibai : String?
    @objc dynamic var created_at : String?
    @objc dynamic var updated_at : String?
    @objc dynamic var ngonngu: Int = 0
    @objc dynamic var isFavorite: Bool = false

    // MARK: - For Decodable
	enum CodingKeys: String, CodingKey {
		case id = "id"
		case tieude = "tieude"
		case loibai = "loibai"
		case created_at = "created_at"
		case updated_at = "updated_at"
		case ngonngu = "ngonngu"
	}

    required init(from decoder: Decoder) throws {
        super.init()
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id) ?? UnknownID
		tieude = try values.decodeIfPresent(String.self, forKey: .tieude)
		loibai = try values.decodeIfPresent(String.self, forKey: .loibai)
		created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
		updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
		ngonngu = try values.decodeIfPresent(Int.self, forKey: .ngonngu) ?? 0
	}
    
    // MARK: - For Realm
    required init() {
        super.init()
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    override static func primaryKey() -> String? {
        return #keyPath(SongResponse.id)
    }
    
    override static func indexedProperties() -> [String] {
        return [
            #keyPath(SongResponse.ngonngu),
            #keyPath(SongResponse.isFavorite)
        ]
    }
}

extension SongResponse {
    var isValid: Bool {
        return id != UnknownID
    }
    
    var languageName: String {
        return (SongLanguage(rawValue: ngonngu) ?? SongLanguage.unknown).description
    }
}
