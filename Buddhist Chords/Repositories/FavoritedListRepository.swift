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
    func checkFavorited(_ songId: Int) -> Bool
    func addSong(_ song: Song)
    func removeSong(_ songId: Int)
    func addSongs(_ songs: [Song])
    func removeSongs(_ songIds: [Int])
    var dataUpdateClosure: (()->())? { get }
}

class FavoritedListRepository: FavoritedListRepositoryProtocol {
    
    static let shared = FavoritedListRepository()
    
    private init() {
        
    }
    
    var list: [Song] { return [] } // TODO:
    
    func checkFavorited(_ songId: Int) -> Bool {
        let checkSong = list.first { ($0.id ?? NSNotFound) == songId }
        return checkSong != nil
    }
    func addSong(_ song: Song) {
        // TODO: add logic
        
        // notify
        dataUpdateClosure?()
    }
    func removeSong(_ songId: Int) {
        // TODO: add logic
        
        // notify
        dataUpdateClosure?()
    }
    func addSongs(_ songs: [Song]) {
        // TODO: add logic
        
        // notify
        dataUpdateClosure?()
    }
    func removeSongs(_ songIds: [Int]) {
        // TODO: add logic
        
        // notify
        dataUpdateClosure?()
    }
    
    var dataUpdateClosure: (()->())?
}
