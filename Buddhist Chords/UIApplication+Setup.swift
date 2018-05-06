//
//  UIApplication+Setup.swift
//  Buddhist Chords
//
//  Created by Viet Nguyen Tran on 4/14/18.
//  Copyright © 2018 iossimple. All rights reserved.
//

import UIKit
import DropDown
import Fabric
import Crashlytics

extension UIApplication {
    static func setupRootVC() -> UIViewController {
        let remoteTitle = NSLocalizedString("All", comment: "All Name")
        let remoteVM = RemoteListViewModel()
        let remoteList = SongsListViewController(viewModel: remoteVM)
        remoteList.title = remoteTitle
        remoteList.navigationItem.rightBarButtonItem = UIBarButtonItem.selectLanguageItem(withSelectAction: remoteVM)
        remoteList.navigationItem.leftBarButtonItem = UIBarButtonItem.searchItem
        remoteList.tabBarItem = UITabBarItem(title: remoteTitle, image: #imageLiteral(resourceName: "tabbar_new"), tag: 0)
        
        let favoriteTitle = NSLocalizedString("Favorited", comment: "Favorited List Name")
        let favoriteVM = FavoriteListViewModel()
        let favoriteList = SongsListViewController(viewModel: favoriteVM)
        favoriteList.title = favoriteTitle
        favoriteList.navigationItem.leftBarButtonItem = UIBarButtonItem.searchItem
        favoriteList.tabBarItem = UITabBarItem(title: favoriteTitle, image: #imageLiteral(resourceName: "tabbar_favorite"), tag: 1)
        
        let tabbarVC = UITabBarController()
        tabbarVC.viewControllers = [
            UINavigationController(rootViewController: remoteList),
            UINavigationController(rootViewController: favoriteList)
        ]
        
        if #available(iOS 10, *) {
            // ok, nothing
        } else {
            extraTabbarConfigForiOSBelow10(tabbar: tabbarVC.tabBar)
        }
        
        return tabbarVC
    }
    
    static func setupSearchVC() -> UIViewController {
        let viewModel = SearchViewModel()
        let search = SearchViewController(viewModel: viewModel)
        let naviVC = UINavigationController(rootViewController: search)
        
        return naviVC
    }
    
    static func appUIConfig() {
        UINavigationBar.appearance().barTintColor = UIColor(r: 76, g: 134, b: 191)
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        let tabColorNormal = UIColor.lightGray
        let tabColorHighlight = UIColor.white
        UITabBar.appearance().barTintColor = UIColor(r: 76, g: 134, b: 191)
        UITabBar.appearance().tintColor = tabColorHighlight
        if #available(iOS 10, *) {
            UITabBar.appearance().unselectedItemTintColor = tabColorNormal
        } else {
            // show sad face emoji
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor : tabColorNormal], for: .normal)
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor : tabColorHighlight], for: .selected)
        }
        
        UISearchBar.appearance().barTintColor = .red
        UISearchBar.appearance().tintColor = .white
    }
    
    static func launchConfig() {
        DropDown.startListeningToKeyboard()
        Fabric.with([Crashlytics.self])
    }
}

// Utility
extension UIApplication {
    static func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
    
    static func currentNavigationController() -> UINavigationController? {
        return topViewController()?.navigationController
    }
}

extension UIApplication {
    private static func extraTabbarConfigForiOSBelow10(tabbar: UITabBar) {
        guard let items = tabbar.items else {
            return
        }
        let tabColorNormal = UIColor.lightGray
        for item in items {
            // .with(color: tabColorNormal)
            item.image = item.selectedImage?.with(color: tabColorNormal)?.withRenderingMode(.alwaysOriginal)
        }
    }
}
