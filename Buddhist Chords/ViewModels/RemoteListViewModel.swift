//
//  RemoteListViewModel.swift
//  Buddhist Chords
//
//  Created by Viet Nguyen Tran on 4/14/18.
//  Copyright © 2018 iossimple. All rights reserved.
//

import Foundation

class RemoteListViewModel: SongsListViewModelProtocol {
    private var remoteRepository = RemoteListRepository()
    private var favoritedRepository = FavoritedListRepository.shared
    
    var list: [Song] {
        return remoteRepository.list
    }
    
    var viewState: ViewState = .blank
    
    var dataUpdateClosure: ((ViewState) -> ())?
    
    init() {
        remoteRepository.requestStateUpdateClosure = { [weak self] rState in
            self?.handle(requestState: rState)
        }
        remoteRepository.fetch()
    }
    
    func handle(requestState: RequestState) {
        switch requestState {
        case .notStarted:
            break
        case .running:
            viewState = .loading
        case .cancelled:
            break
        case .error(let error):
            viewState = .error(error)
        case .successful(_):
            viewState = .data(nil)
        }
    }
}
