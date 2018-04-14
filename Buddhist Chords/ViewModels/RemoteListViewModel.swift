//
//  RemoteListViewModel.swift
//  Buddhist Chords
//
//  Created by Viet Nguyen Tran on 4/14/18.
//  Copyright © 2018 iossimple. All rights reserved.
//

import Foundation

class RemoteListViewModel: SongsListViewModelProtocol {
    private var _list: [Song]? = nil
    
    var list: [Song] {
        if let _list = _list {
            return _list
        } else {
            return []
        }
    }
    
    var viewState: ViewState = .blank
    
    var dataUpdateClosure: ((ViewState) -> ())?
    
    // TODO: connect with Repository
}
