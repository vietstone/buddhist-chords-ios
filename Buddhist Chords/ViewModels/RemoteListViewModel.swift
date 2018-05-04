//
//  RemoteListViewModel.swift
//  Buddhist Chords
//
//  Created by Viet Nguyen Tran on 4/14/18.
//  Copyright © 2018 iossimple. All rights reserved.
//

import Foundation

class RemoteListViewModel: SongsListViewModelProtocol {
    
    var list: [Song] {
        switch language {
        case .vietnamese: return vietnameseList
        case .english: return englishList
        case .thai: return thaiList
        case .all: return allList
        default: return vietnameseList // error, then return default to vietnameseList
        }
    }
    
    var vietnameseList: [Song] {
        return repository.list.filter("ngonngu = %d", SongLanguage.vietnamese.rawValue).compactMap { $0 }
    }
    
    var englishList: [Song] {
        return repository.list.filter("ngonngu = %d", SongLanguage.english.rawValue).compactMap { $0 }
    }
    
    var thaiList: [Song] {
        return repository.list.filter("ngonngu = %d", SongLanguage.thai.rawValue).compactMap { $0 }
    }
    
    var allList: [Song] {
        return repository.list.compactMap { $0 }
    }
    
    var dataUpdateClosure: ((ViewState) -> ())?
    
    private var viewState: ViewState = .blank {
        didSet {
            dataUpdateClosure?(viewState)
        }
    }
    
    private var language: SongLanguage = .unknown {
        didSet {
            // re-inform the view to update data
            let state = ViewState.data(nil)
            dataUpdateClosure?(state)
        }
    }
    
    private var repository: SongsRepositoryProtocol
    
    init() {
        repository = SongsRepository()
    }
    
    private func handle(requestState: RequestState) {
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
    
    func fetch() {
        repository.fetch { [weak self] (requestState) in
            self?.handle(requestState: requestState)
        }
    }
}

extension RemoteListViewModel: SelectLanguageProtocol {
    func select(language: SongLanguage) {
        self.language = language
    }
}
