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
        let remoteTitle = NSLocalizedString("All", comment: "All Name")
        let remoteVM = RemoteListViewModel()
        let remoteList = SongsListViewController(viewModel: remoteVM)
        remoteList.title = remoteTitle
        remoteList.navigationItem.rightBarButtonItem = SelectLanguageBarItemBuilder.getItem(with: remoteVM)
        remoteList.tabBarItem = UITabBarItem(title: remoteTitle, image: #imageLiteral(resourceName: "tabbar_new"), tag: 0)
        
        let favoriteTitle = NSLocalizedString("Favorited", comment: "Favorited List Name")
        let favoriteVM = FavoriteListViewModel()
        let favoriteList = SongsListViewController(viewModel: favoriteVM)
        favoriteList.title = favoriteTitle
        favoriteList.tabBarItem = UITabBarItem(title: favoriteTitle, image: #imageLiteral(resourceName: "tabbar_favorite"), tag: 1)
        
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
        UITabBar.appearance().unselectedItemTintColor = .lightGray
    }
    
    static func launchConfig() {
        DropDown.startListeningToKeyboard()
    }
}
