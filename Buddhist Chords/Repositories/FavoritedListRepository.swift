//
//  FavoritedListRepository.swift
//  Buddhist Chords
//
//  Created by Viet Nguyen Tran on 4/9/18.
//  Copyright © 2018 iossimple. All rights reserved.
//

import Foundation

protocol FavoritedListRepositoryProtocol {
    var list: [Song] { get }
    func addSong(_ song: Song)
    func removeSong(_ songId: Int)
    func addSongs(_ songs: [Song])
    func removeSongs(_ songIds: [Int])
}

class FavoritedListRepository {
    
}
