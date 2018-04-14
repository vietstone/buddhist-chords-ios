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
    func removeSong(_ song: Song)
    func addSongs(_ songs: [Song])
    func removeSongs(_ songs: [Song])
    var dataUpdateClosure: (()->())? { get set }
}

// TODO: cache logic
class FavoritedListRepository: FavoritedListRepositoryProtocol {
    static let shared = FavoritedListRepository()
    
    private init() {
        
    }
    
    private(set) var list: [Song] = []
    
    func checkFavorited(_ songId: Int) -> Bool {
        let checkSong = list.first { ($0.id ?? NSNotFound) == songId }
        return checkSong != nil
    }
    func addSong(_ song: Song) {
        self.addSong(song, turnOnNotify: true)
    }
    
    func removeSong(_ song: Song) {
        self.removeSong(song, turnOnNotify: true)
    }
    func addSongs(_ songs: [Song]) {
        songs.forEach { addSong($0, turnOnNotify: false) }
        dataUpdateClosure?()
    }
    func removeSongs(_ songs: [Song]) {
        songs.forEach { removeSong($0, turnOnNotify: false) }
        dataUpdateClosure?()
    }
    
    var dataUpdateClosure: (()->())?
}

extension FavoritedListRepository {
    private func addSong(_ song: Song, turnOnNotify: Bool) {
        // verify
        guard song.isValid, !list.contains(song) else {
            return
        }
        // add
        list.append(song)
        // notify
        if turnOnNotify {
            dataUpdateClosure?()
        }
    }
    private func removeSong(_ song: Song, turnOnNotify: Bool) {
        // verify
        guard let indexToRemove = list.index(of: song) else {
            return
        }
        // remove
        list.remove(at: indexToRemove)
        // notify
        if turnOnNotify {
            dataUpdateClosure?()
        }
    }
}
