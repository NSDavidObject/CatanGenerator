//
//  UIFont+AppFonts.swift
//  Catan
//
//  Created by David Elsonbaty on 8/19/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import UIKit

extension UIFont {
    
    static let appFontDefaultThin: UIFont = UIFont(name: "CoreSansAR-15Thin", size: 12.0)!
    static let appFontDefaultLight: UIFont = UIFont(name: "CoreSansAR-35Light", size: 12.0)!
    static let appFontDefaultExtraLight: UIFont = UIFont(name: "CoreSansAR-25ExtraLight", size: 12.0)!
    
    // MARK: - Main View Controller
    static let appFontMainViewControllerGenerateButton: UIFont = UIFont.appFontDefaultLight.withSize(20.0)
    static let appFontMainViewControllerGameTypeTitleLabel: UIFont = UIFont.appFontDefaultLight.withSize(16.0)
    
}
