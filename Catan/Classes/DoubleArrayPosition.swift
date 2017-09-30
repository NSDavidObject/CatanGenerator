//
//  DoubleArrayPosition.swift
//  Catan
//
//  Created by David Elsonbaty on 9/30/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import Foundation

struct DoubleArrayPosition {
    
    let positionX: Int
    let positionY: Int
    
    init(positionX: Int, positionY: Int) {
        self.positionX = positionX
        self.positionY = positionY
    }
    
    init?(positionX: Int, positionY: Int, inDoubleArray doubleArray: [[Any]]) {
        guard let _ = doubleArray[safe: positionY]?[safe: positionX] else { return nil }
        self.init(positionX: positionX, positionY: positionY)
    }
 
    static func firstPosition(in doubleArray: [[Any]]) -> DoubleArrayPosition? {
        return DoubleArrayPosition(positionX: -1, positionY: 0).nextSubsequentPosition(in: doubleArray)
    }
    
    func element<T>(inDoubleArray doubleArray: [[T]]) -> T? {
        return doubleArray[safe: positionY]?[safe: positionX]
    }
    
    func nextSubsequentPosition(in doubleArray: [[Any]]) -> DoubleArrayPosition? {
        let nextColumnIndex = positionX + 1
        let nextRowIndex = positionY + 1
        if doubleArray[positionY].count > nextColumnIndex {
            return DoubleArrayPosition(positionX: nextColumnIndex, positionY: positionY)
        } else if doubleArray.count > nextRowIndex {
            return DoubleArrayPosition(positionX: -1, positionY: nextRowIndex).nextSubsequentPosition(in: doubleArray)
        }
        return nil
    }
}

extension DoubleArrayPosition: Hashable {
    
    var hashValue: Int {
        return positionX.hashValue ^ positionY.hashValue
    }
    
    static func == (lhs: DoubleArrayPosition, rhs: DoubleArrayPosition) -> Bool {
        return lhs.positionX == rhs.positionX &&
            lhs.positionY == rhs.positionY
    }
}
