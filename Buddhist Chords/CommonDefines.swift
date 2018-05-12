//
//  CommonDefines.swift
//  Buddhist Chords
//
//  Created by Viet Nguyen Tran on 4/25/18.
//  Copyright © 2018 iossimple. All rights reserved.
//

import Foundation

protocol Song {
    var name: String { get }
    var language: SongLanguage { get }
    var content: String { get }
    var contentPreview: String { get }
    var isFavorited: Bool { get }
    func toggleFavorite()
}

enum ViewState {
    case blank
    case loading
    case data(Any?)
    case error(Error)
}

protocol SongsListViewModelProtocol {
    var list: [Song] { get }
    var dataUpdateClosure: ((ViewState)->())? { get set }
    
    var canFetch: Bool { get }
    func fetch()
}

extension SongsListViewModelProtocol {
    var canFetch: Bool { return true }
}

protocol SelectLanguageProtocol {
    func select(language: SongLanguage)
}
