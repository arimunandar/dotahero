//
//  Extension+UIViewController.swift
//  DotaHero
//
//  Created by Ari Munandar on 18/10/20.
//  Copyright © 2020 Ari Munandar. All rights reserved.
//

import UIKit

extension UIViewController {
    @IBInspectable
    var backIcon: UIImage? {
        get {
            return nil
        } set {
            navigationController?.navigationBar.backIndicatorImage = newValue?.withRenderingMode(.alwaysOriginal)
            navigationController?.navigationBar.backIndicatorTransitionMaskImage = newValue?.withRenderingMode(.alwaysOriginal)
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
    }

    @IBInspectable
    var navbarColor: UIColor? {
        get {
            return self.navigationController?.navigationBar.barTintColor
        } set {
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.isTranslucent = newValue == .clear ? true : false
            self.navigationController?.navigationBar.barTintColor = newValue
            self.navigationController?.navigationBar.tintColor = .white
            let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            navigationController?.navigationBar.titleTextAttributes = textAttributes
        }
    }
}
