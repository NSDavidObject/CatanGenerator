//
//  Array+Additions.swift
//  Catan
//
//  Created by David Elsonbaty on 12/25/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import Foundation

extension Array {
    
    mutating func dropFirst(where predicate: (Element) throws -> Bool) rethrows -> Element? {
        var currentIndex = 0
        while currentIndex < self.count {
            if try predicate(self[currentIndex]) {
                return remove(at: currentIndex)
            }
            currentIndex += 1
        }
        return nil
    }
    
    init(_ elementConstructor: @autoclosure (Int) -> Element, count: Int) {
        self.init(count.map({ elementConstructor($0) }))
    }
}

extension Dictionary {
    
    func combine<E>(withDictionary dict: Dictionary<Key, E>) -> Dictionary<Key, (Value, E)>? {
        guard dict.keys.allPass({ self.keys.contains($0) }) else { return nil }
        
        var result: [Key: (Value, E)] = [:]
        for (key, value) in self {
            guard let otherValue = dict[key] else { return nil }
            result[key] = (value, otherValue)
        }
        return result
    }
}
