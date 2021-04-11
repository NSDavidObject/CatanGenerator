//  
//  Collection+Additions.swift
//  Catan
//
//  Created by David Elsonbaty on 8/20/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import Foundation

extension Collection {
    
    /// Return a copy of `self` with its elements shuffled
    func shuffled() -> [Iterator.Element] {
        var list = Array(self)
        list.shuffle()
        return list
    }
    
    public subscript(safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
    public func allPass(_ checker: (Iterator.Element) -> Bool) -> Bool {
        for element in self where !checker(element) {
            return false
        }
        return true
    }
}
