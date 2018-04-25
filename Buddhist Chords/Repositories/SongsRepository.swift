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
    var list: List<SongResponse> {
        let realm = try! Realm(configuration: RealmConfig.main.configuration)
        return User.defaultUser(in: realm).list
    }
    
    func fetch(requestStateObserver: ((RequestState) -> Void)?) {
        // TODO:
    }
    
    
    
}
