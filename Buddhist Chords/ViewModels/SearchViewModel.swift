//
//  SearchViewModel.swift
//  Buddhist Chords
//
//  Created by Viet Nguyen Tran on 5/5/18.
//  Copyright © 2018 iossimple. All rights reserved.
//

import Foundation

class SearchViewModel: SongsListViewModelProtocol {
    var list: [Song] {
        return repo.list.compactMap { $0 } // TODO: filter
    }
    
    var dataUpdateClosure: ((ViewState) -> ())?
    
    private var repo: SongsRepositoryProtocol
    private var filterText: String?
    
    init() {
        repo = SongsRepository()
    }
    
    func fetch() { // No use, just here for protocol
    }
    
    func filter(with text: String?) {
        self.filterText = text
        dataUpdateClosure?(.data(nil))
    }
}
