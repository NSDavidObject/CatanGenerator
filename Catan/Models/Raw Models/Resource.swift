//
//  Resource.swift
//  Catan
//
//  Created by David Elsonbaty on 8/19/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import UIKit

enum Resource: Int, Equatable {
    case hay
    case clay
    case stone
    case sheep
    case wood
    case gold
    
    var color: UIColor {
        switch self {
        case .hay: return UIColor(red:203.0/255.0, green:172.0/255.0, blue:0.0/255.0, alpha:255.0/255.0)
        case .clay: return UIColor(red:165.0/255.0, green:63.0/255.0, blue:0.0/255.0, alpha:255.0/255.0)
        case .stone: return UIColor(red:54.0/255.0, green:59.0/255.0, blue:62.0/255.0, alpha:255.0/255.0)
        case .sheep: return UIColor(red:157.0/255.0, green:206.0/255.0, blue:120.0/255.0, alpha:255.0/255.0)
        case .wood: return UIColor(red:66.0/255.0, green:89.0/255.0, blue:47.0/255.0, alpha:255.0/255.0)
        case .gold: return UIColor(red:253.0/255.0, green:190.0/255.0, blue:45.0/255.0, alpha:255.0/255.0)
        }
    }
}

extension Resource: CustomDebugStringConvertible {
    
    var debugDescription: String {
        switch self {
        case .hay: return "hay"
        case .clay: return "clay"
        case .stone: return "stone"
        case .sheep: return "sheep"
        case .wood: return "wood"
        case .gold: return "gold"
        }
    }
}
