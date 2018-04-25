//
//  UIAlertController+.swift
//  Buddhist Chords
//
//  Created by Viet Nguyen Tran on 4/25/18.
//  Copyright © 2018 iossimple. All rights reserved.
//

import UIKit

extension UIAlertController {
    static func errorAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: nil))
        return alert
    }
}
