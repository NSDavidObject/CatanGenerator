//
//  DiceCombination.swift
//  Catan
//
//  Created by David Elsonbaty on 8/19/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import Foundation

enum DiceCombination: Int {
    
    enum Probability: Int {
        case one = 1
        case two = 2
        case three = 3
        case four = 4
        case five = 5
        
        var isHighest: Bool {
            switch self {
            case .five: return true
            default: return false
            }
        }
    }
    
    case two = 2
    case three = 3
    case four = 4
    case five = 5
    case six = 6
    case eight = 8
    case nine = 9
    case ten = 10
    case eleven = 11
    case twelve = 12
    
    var probability: Probability {
        switch self {
        case .two: return .one
        case .three: return .two
        case .four: return .three
        case .five: return .four
        case .six: return .five
        case .eight: return .five
        case .nine: return .four
        case .ten: return .three
        case .eleven: return .two
        case .twelve: return .one
        }
    }
}
