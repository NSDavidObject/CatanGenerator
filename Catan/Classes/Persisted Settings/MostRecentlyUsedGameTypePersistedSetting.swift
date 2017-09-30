//
//  MostRecentlyUsedGameTypePersistedSetting.swift
//  Catan
//
//  Created by David Elsonbaty on 9/30/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import Foundation

struct MostRecentlyUsedGameTypePersistedSetting: DefaultsGameType {
    static var name: String = "most-recently-used-game-type"
    static var defaultValue: GameType = .classic
}
