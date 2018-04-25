//
//  FavoriteListViewModel.swift
//  Buddhist Chords
//
//  Created by Viet Nguyen Tran on 4/14/18.
//  Copyright © 2018 iossimple. All rights reserved.
//

import Foundation

class FavoriteListViewModel: SongsListViewModelProtocol {
    var list: [Song] {
        return repository.list.filter("isFavorite = true").compactMap { $0 }
    }
    
    var dataUpdateClosure: ((ViewState) -> ())? // No use, just here for protocol
    
    private var repository: SongsRepositoryProtocol
    
    init() {
        repository = SongsRepository()
    }
    
    func fetch() { // No use, just here for protocol
    }
}
