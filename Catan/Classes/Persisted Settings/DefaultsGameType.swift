//
//  DefaultsGameType.swift
//  Catan
//
//  Created by David Elsonbaty on 9/30/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import Foundation

protocol DefaultsGameType: DefaultsItem where Value == GameType {}
extension DefaultsGameType {
    static var value: GameType {
        return UserDefaults.standard.optionalInteger(forKey: userDefaultsName).flatMap { GameType(rawValue: $0) } ?? defaultValue
    }
    static func set(value: GameType) {
        UserDefaults.standard.set(value.rawValue, forKey: userDefaultsName)
    }
}
