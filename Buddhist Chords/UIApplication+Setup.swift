//
//  UIApplication+Setup.swift
//  Buddhist Chords
//
//  Created by Viet Nguyen Tran on 4/14/18.
//  Copyright © 2018 iossimple. All rights reserved.
//

import UIKit
import DropDown

extension UIApplication {
    static func setupRootVC() -> UIViewController {
        let remoteVM = RemoteListViewModel()
        let remoteList = SongsListViewController(viewModel: remoteVM)
        remoteList.title = NSLocalizedString("New List", comment: "New List Name")
        remoteList.navigationItem.rightBarButtonItem = SelectLanguageBarItemBuilder.getItem(with: remoteVM)
        
        let favoriteVM = FavoriteListViewModel()
        let favoriteList = SongsListViewController(viewModel: favoriteVM)
        favoriteList.title = NSLocalizedString("Favorited", comment: "Favorited List Name")
        
        let tabbarVC = UITabBarController()
        tabbarVC.viewControllers = [
            UINavigationController(rootViewController: remoteList),
            UINavigationController(rootViewController: favoriteList)
        ]
        
        return tabbarVC
    }
    
    static func appUIConfig() {
        UINavigationBar.appearance().barTintColor = UIColor(r: 76, g: 134, b: 191)
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        UITabBar.appearance().barTintColor = UIColor(r: 76, g: 134, b: 191)
        UITabBar.appearance().tintColor = .white
    }
    
    static func launchConfig() {
        DropDown.startListeningToKeyboard()
    }
}
