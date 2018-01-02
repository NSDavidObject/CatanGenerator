//
//  Resource.swift
//  Catan
//
//  Created by David Elsonbaty on 8/19/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import UIKit

enum Resource: Int {
    case hay
    case clay
    case stone
    case sheep
    case wood
    
    var color: UIColor {
        switch self {
        case .hay: return UIColor(red:203.0/255.0, green:172.0/255.0, blue:0.0/255.0, alpha:255.0/255.0)
        case .clay: return UIColor(red:165.0/255.0, green:63.0/255.0, blue:0.0/255.0, alpha:255.0/255.0)
        case .stone: return UIColor(red:54.0/255.0, green:59.0/255.0, blue:62.0/255.0, alpha:255.0/255.0)
        case .sheep: return UIColor(red:157.0/255.0, green:206.0/255.0, blue:120.0/255.0, alpha:255.0/255.0)
        case .wood: return UIColor(red:66.0/255.0, green:89.0/255.0, blue:47.0/255.0, alpha:255.0/255.0)
        }
    }
}
