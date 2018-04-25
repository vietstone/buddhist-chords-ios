//
//  UIApplication+Setup.swift
//  Buddhist Chords
//
//  Created by Viet Nguyen Tran on 4/14/18.
//  Copyright © 2018 iossimple. All rights reserved.
//

import UIKit

extension UIApplication {
    static func setupRootVC() -> UIViewController {
        let remoteVM = RemoteListViewModel()
        let remoteList = SongsListViewController(viewModel: remoteVM)
        remoteList.title = "Remote List"
        
        let favoriteVM = FavoriteListViewModel()
        let favoriteList = SongsListViewController(viewModel: favoriteVM)
        favoriteList.title = "Favorited List"
        
        let tabbarVC = UITabBarController()
        tabbarVC.viewControllers = [
            UINavigationController(rootViewController: remoteList),
            UINavigationController(rootViewController: favoriteList)
        ]
        
        return tabbarVC
    }
}
