//
//  SelectLanguageBarItemBuilder.swift
//  Buddhist Chords
//
//  Created by Viet Nguyen Tran on 4/25/18.
//  Copyright © 2018 iossimple. All rights reserved.
//

import Foundation
import DropDown

final class BarButtonItemBuilder {
    
    // MARK: - Select Language Item
    private static var dropDown = DropDown()
    @objc private static func onLanguageTap() {
        dropDown.show()
    }
    static func buildSelectLanguageItem(withSelectAction action: SelectLanguageProtocol) -> UIBarButtonItem {
        // 3 things to care: action, title, setting
        let userSetting = UserDefaults.standard
        let languageSetting = userSetting.integer(forKey: AppConfig.languageUserDefaultsSettingKey) // default is 0, to Vietnamese
        let currentLanguage = SongLanguage(rawValue: languageSetting) ?? .unknown
        
        let barItem = UIBarButtonItem(title: currentLanguage.settingDescription,
                                      style: .plain, target: self, action: #selector(onLanguageTap))
        action.select(language: currentLanguage)
        
        let appLanguages = AppConfig.appLanguages
        dropDown.dataSource = appLanguages.map { $0.settingDescription }
        dropDown.selectionAction = { [action, barItem, appLanguages, userSetting] (index, item) in
            let language = appLanguages[index]
            action.select(language: language)
            barItem.title = language.settingDescription
            userSetting.set(language.rawValue, forKey: AppConfig.languageUserDefaultsSettingKey)
            userSetting.synchronize()
        }
        
        dropDown.anchorView = barItem
        
        return barItem
    }

    // MARK: - Search Item
    @objc private static func onSearchTap() {
        if let topVC = UIApplication.topViewController() {
            let searchVC = UIApplication.setupSearchVC()
            topVC.present(searchVC, animated: true, completion: nil)
        }
    }
    static func buildSearchItem() -> UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(onSearchTap))
    }
}
