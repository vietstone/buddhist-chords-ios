//
//  ChordsAPI.swift
//  Buddhist Chords
//
//  Created by Viet Nguyen Tran on 4/14/18.
//  Copyright © 2018 iossimple. All rights reserved.
//

import Foundation
import PromiseKit

class ChordsAPI: APIClient {
    static func fetchSongs() -> Promise<[SongResponse]> {
        return self.dataRequest(path: "/thienca")
    }
}
