//
//  AppDelegate+Setup.swift
//  Buddhist Chords
//
//  Created by Viet Nguyen Tran on 4/14/18.
//  Copyright © 2018 iossimple. All rights reserved.
//

import UIKit

extension AppDelegate {
    static func setupRootVC() -> UIViewController {
        let remoteVM = RemoteListViewModel()
        let remoteList = SongsListViewController(viewModel: remoteVM)
        remoteList.title = "Remote List"
        
        let favoritedRepo = FavoritedListRepository.shared
        let favoritedVM = FavoritedListViewModel(repository: favoritedRepo)
        let favoritedList = SongsListViewController(viewModel: favoritedVM)
        favoritedList.title = "Favorited List"
        
        let tabbarVC = UITabBarController()
        tabbarVC.viewControllers = [remoteList, favoritedList]
        
        return tabbarVC
    }
}
