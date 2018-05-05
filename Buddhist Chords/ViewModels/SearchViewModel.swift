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
        // NSPredicate(format: "color = %@ AND name BEGINSWITH %@", "tan", "B")
        var predicate = NSPredicate(value: true)
        if let filterText = filterText, filterText.count != 0 {
            predicate = NSPredicate(format: "tieude contains[cd] %@", filterText)
        }
        return repo.list.filter(predicate).compactMap { $0 } // TODO: filter
    }
    
    var dataUpdateClosure: ((ViewState) -> ())?
    
    private var repo: SongsRepositoryProtocol
    private var filterText: String?
    
    init() {
        repo = SongsRepository()
    }
    
    var canFetch: Bool { return false }
    
    func fetch() { // No use, just here for protocol
    }
    
    func filter(with text: String?) {
        self.filterText = text
        dataUpdateClosure?(.data(nil))
    }
}
