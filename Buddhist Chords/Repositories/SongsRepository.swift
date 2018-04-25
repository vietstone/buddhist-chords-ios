//
//  RemoteListRepository.swift
//  Buddhist Chords
//
//  Created by Viet Nguyen Tran on 4/9/18.
//  Copyright © 2018 iossimple. All rights reserved.
//

import Foundation
import RealmSwift

enum RequestState {
    case notStarted
    case running
    case cancelled
    case error(Error)
    case successful(Any?)
}

protocol SongsRepositoryProtocol {
    var list: List<SongResponse> { get }
    func fetch(requestStateObserver: ((RequestState) -> Void)?)
}

class SongsRepository: SongsRepositoryProtocol {
    private var getRealm: Realm {
        return try! Realm(configuration: RealmConfig.main.configuration)
    }
    
    var list: List<SongResponse> {
        let realm = self.getRealm
        return User.defaultUser(in: realm).list
    }
    
    func fetch(requestStateObserver: ((RequestState) -> Void)?) {
        requestStateObserver?(.running)
        ChordsAPI.fetchSongs()
            .done { [weak self] songResponses in
                guard let realm = self?.getRealm else { return }
                let me = User.defaultUser(in: realm)
                try? realm.write {
                    for song in songResponses {
                        let id = song.id
                        if me.list.filter("id = %d", id).count == 0 {
                            me.list.append(song)
                        } else {
                            let realmSong = realm.object(ofType: SongResponse.self, forPrimaryKey: id)
                            realmSong?.updateContent(from: song)
                        }
                    }
                }
                requestStateObserver?(.successful(nil))
            }.catch { error in
                requestStateObserver?(.error(error))
        }
    }
    
    
    
}
