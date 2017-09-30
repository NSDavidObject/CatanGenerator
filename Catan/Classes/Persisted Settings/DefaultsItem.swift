//
//  DefaultsItem.swift
//  Catan
//
//  Created by David Elsonbaty on 9/30/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import Foundation

protocol DefaultsItem {
    associatedtype Value
    static var name: String { get }
    static var defaultValue: Value { get }
}

extension DefaultsItem {
    static var userDefaultsName: String {
        return "com.catan.defaults." + name
    }
}

protocol DefaultsString: DefaultsItem where Value == String {}

extension DefaultsString {
    static var value: String {
        return UserDefaults.standard.string(forKey: userDefaultsName) ?? defaultValue
    }
    static func set(value: String) {
        UserDefaults.standard.set(value, forKey: userDefaultsName)
    }
}

protocol DefaultsNumber: DefaultsItem where Value == Int {}

extension DefaultsNumber {
    static var value: Int {
        return UserDefaults.standard.optionalInteger(forKey: userDefaultsName) ?? defaultValue
    }
    static func set(value: Int) {
        UserDefaults.standard.set(value, forKey: userDefaultsName)
    }
}

protocol DefaultsBoolean: DefaultsItem where Value == Bool {}
