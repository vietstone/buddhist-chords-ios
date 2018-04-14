//
//  FavoritedListViewModel.swift
//  Buddhist Chords
//
//  Created by Viet Nguyen Tran on 4/14/18.
//  Copyright © 2018 iossimple. All rights reserved.
//

import Foundation

class FavoritedListViewModel: SongsListViewModelProtocol {
    private var repository: FavoritedListRepositoryProtocol!
    
    var list: [Song] { return repository.list }
    
    var viewState: ViewState = .blank
    
    var dataUpdateClosure: ((ViewState) -> ())?
    
    init(repository: FavoritedListRepositoryProtocol) {
        self.repository = repository
        self.viewState = .data(nil)
    }
}
