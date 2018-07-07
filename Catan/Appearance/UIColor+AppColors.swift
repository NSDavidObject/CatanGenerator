//
//  UIColor+AppColors.swift
//  Catan
//
//  Created by David Elsonbaty on 8/19/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import UIKit

extension UIColor {
    
    static let appColorMainColor: UIColor = UIColor(red:254.0/255.0, green:204.0/255.0, blue:133.0/255.0, alpha:255.0/255.0)
    static let appColorBrown: UIColor = UIColor(hex: "7E5028")
    
    // MARK: - Main View Controller
    static let appColorMainViewControllerGenerateButton: UIColor = UIColor.appColorMainColor
    static let appColorMainViewControllerGameTypeTitleLabel: UIColor = UIColor.appColorMainColor.withAlphaComponent(0.5)
}
