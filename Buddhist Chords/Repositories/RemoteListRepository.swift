//
//  RemoteListRepository.swift
//  Buddhist Chords
//
//  Created by Viet Nguyen Tran on 4/9/18.
//  Copyright © 2018 iossimple. All rights reserved.
//

import Foundation

enum RequestState {
    case notStarted
    case running
    case cancelled
    case error(Error)
    case successful(Any?)
}

protocol RemoteListRepositoryProtocol {
    var list: [Song] { get }
    
    var requestState: RequestState { get }
    var requestStateUpdateClosure: ((RequestState)->())? { get set }
    func fetch()
}

class RemoteListRepository: RemoteListRepositoryProtocol {
    private var _list: [Song]? = nil
    
    var list: [Song] {
        if let _list = _list {
            return _list
        } else {
            return []
        }
    }
    
    var requestState: RequestState = .notStarted
    
    var requestStateUpdateClosure: ((RequestState) -> ())?
    
    func fetch() {
        // TODO: load from network
    }
}
