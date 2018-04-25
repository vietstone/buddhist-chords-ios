//
//  SelectLanguageBarItemBuilder.swift
//  Buddhist Chords
//
//  Created by Viet Nguyen Tran on 4/25/18.
//  Copyright © 2018 iossimple. All rights reserved.
//

import Foundation
import DropDown

final class SelectLanguageBarItemBuilder {
    private static var dropDown = DropDown()
    
    static func getItem(with action: SelectLanguageProtocol) -> UIBarButtonItem {
        let userSetting = UserDefaults.standard
        let languageSetting = userSetting.integer(forKey: AppConfig.languageUserDefaultsSettingKey) // default is 0, to Vietnamese
        let currentLanguage = SongLanguage(rawValue: languageSetting) ?? .unknown
        
        let barItem = UIBarButtonItem(title: currentLanguage.settingDescription,
                                      style: .plain, target: self, action: #selector(onTap))
        
        let appLanguages = AppConfig.appLanguages
        dropDown.dataSource = appLanguages.map { $0.settingDescription }
        dropDown.selectionAction = { [action, barItem, appLanguages, userSetting] (index, item) in
            let language = appLanguages[index]
            action.select(language: language)
            barItem.title = language.settingDescription
            userSetting.set(language.rawValue, forKey: AppConfig.languageUserDefaultsSettingKey)
        }
        
        dropDown.anchorView = barItem
        
        return barItem
    }
    
    @objc private static func onTap() {
        dropDown.show()
    }
}
