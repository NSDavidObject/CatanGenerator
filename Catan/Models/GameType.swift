//
//  GameType.swift
//  Catan
//
//  Created by David Elsonbaty on 8/27/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import Foundation

enum GameType: Int {
    case classic
    case extendedClassic
    case seafarers
    
    var name: String {
        switch self {
        case .classic: return "Classic Game"
        case .extendedClassic: return "Classic Game with Extension"
        case .seafarers: return "Seafarers"
        }
    }
    
    var definition: GameDefinition.Type {
        switch self {
        case .classic: return ClassicGame.self
        case .extendedClassic: return ExtendedClassicGame.self
        case .seafarers: return SeafarersGame.self
        }
    }
    
    var nextGameType: GameType {
        return GameType(rawValue: rawValue + 1) ?? (GameType(rawValue: 0) ?? self)
    }
}

