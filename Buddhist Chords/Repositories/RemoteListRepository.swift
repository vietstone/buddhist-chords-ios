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
    func fetch()
    var requestState: RequestState { get }
    var requestStateUpdateClosure: ((RequestState)->())? { get set }
}

class RemoteListRepository: RemoteListRepositoryProtocol {
    
    private(set) var list: [Song] = []
    var requestState: RequestState = .notStarted {
        didSet {
            requestStateUpdateClosure?(requestState)
        }
    }
    
    var requestStateUpdateClosure: ((RequestState) -> ())?
    
    func fetch() {
        // TODO: make net work logic
    }
    
    func fetchCache() {
        self.list = prepareDummyData()
        self.requestState = .successful(nil)
    }
    
    init() {
        fetchCache()
    }
    
    func prepareDummyData() -> [Song] {
        return [
            Song(id: 1, title: "Song 1", language: .vietnamese, body: "<html>html</html>"),
            Song(id: 2, title: "Song 2", language: .vietnamese, body: "<html>html</html>"),
            Song(id: 3, title: "Song 3", language: .vietnamese, body: "<html>html</html>"),
            Song(id: 4, title: "Song 4", language: .vietnamese, body: "<html>html</html>"),
            Song(id: 5, title: "Song 5", language: .vietnamese, body: "<html>html</html>"),
            Song(id: 6, title: "Song 6", language: .vietnamese, body: "<html>html</html>"),
            Song(id: 7, title: "Song 7", language: .vietnamese, body: "<html>html</html>"),
            Song(id: 8, title: "Song 8", language: .vietnamese, body: "<html>html</html>"),
            Song(id: 9, title: "Song 9", language: .vietnamese, body: "<html>html</html>"),
            Song(id: 10, title: "Song 10", language: .vietnamese, body: "<html>html</html>"),
            Song(id: 11, title: "Song 11", language: .vietnamese, body: "<html>html</html>"),
            Song(id: 12, title: "Song 12", language: .vietnamese, body: "<html>html</html>"),
            Song(id: 13, title: "Song 13", language: .vietnamese, body: "<html>html</html>"),
            Song(id: 14, title: "Song 14", language: .vietnamese, body: "<html>html</html>"),
            Song(id: 15, title: "Song 15", language: .vietnamese, body: "<html>html</html>"),
        ]
    }
}
