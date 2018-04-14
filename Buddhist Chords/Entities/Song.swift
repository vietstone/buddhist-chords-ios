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

extension Song {
    var isFavorited: Bool {
        guard let id = id else {
            assert(false, "should not run here")
            return false
        }
        return FavoritedListRepository.shared.checkFavorited(id)
    }
    
    func toggleFavoritedState () {
        if isFavorited {
            removeFromFavorite()
        } else {
            addToFavorite()
        }
    }
    
    private func addToFavorite() {
        FavoritedListRepository.shared.addSong(self)
    }
    
    private func removeFromFavorite() {
        FavoritedListRepository.shared.removeSong(self)
    }
}

extension Song {
    var isValid: Bool { return id != nil }
}

extension Song: Equatable {
    public static func == (lhs: Song, rhs: Song) -> Bool {
        guard let lhsId = lhs.id, let rhsId = rhs.id else {
            return false
        }
        return lhsId == rhsId
    }
}
