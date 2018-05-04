//
//  UIBarButtonItem+.swift
//  Buddhist Chords
//
//  Created by Viet Nguyen Tran on 4/25/18.
//  Copyright © 2018 iossimple. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    static var noTitleBackItem: UIBarButtonItem {
        return UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    static func selectLanguageItem(action: SelectLanguageProtocol) -> UIBarButtonItem {
        return SelectLanguageBarItemBuilder.buildItem(selectLanguageAction: action)
    }
}
