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
}
