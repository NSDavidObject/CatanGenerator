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
        let nextColumnIndex = positionX.successor
        let nextRowIndex = positionY.successor
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

extension DoubleArrayPosition {
    
    enum Adjacent {
        case left
        case right
        case topLeft
        case topRight
        case bottomLeft
        case bottomRight
    }
    
    func adjacentPosition(_ adjacent: Adjacent, inGameBoard gameBoard: GameBoard) -> DoubleArrayPosition? {
        let position: DoubleArrayPosition = adjacentPosition(adjacent, inGameBoard: gameBoard)
        guard let _ = position.element(inDoubleArray: gameBoard.pieces) else { return nil }
        return position
    }
    
    private func adjacentPosition(_ adjacent: Adjacent, inGameBoard gameBoard: GameBoard) -> DoubleArrayPosition {
        switch adjacent {
        case .left: return DoubleArrayPosition(positionX: positionX.predecessor, positionY: positionY)
        case .right: return DoubleArrayPosition(positionX: positionX.successor, positionY: positionY)
        case .topLeft: return positionInPreviousRow(toLeft: true, inGameBoard: gameBoard)
        case .topRight: return positionInPreviousRow(toLeft: false, inGameBoard: gameBoard)
        case .bottomLeft: return positionInNextRow(toLeft: true, inGameBoard: gameBoard)
        case .bottomRight: return positionInNextRow(toLeft: false, inGameBoard: gameBoard)
        }
    }
    
    private func position(toRowCount: Int, toLeft: Bool, toNextRow: Bool, inGameBoard gameBoard: GameBoard) -> DoubleArrayPosition {
        let fromRowCount = gameBoard.pieces[positionY].count
        
        let positionX: Int
        if toLeft {
            positionX = self.positionX - Int(fromRowCount >= toRowCount)
        } else {
            positionX = self.positionX + Int(fromRowCount < toRowCount)
        }
        
        let adjustedPositionY = toNextRow ? positionY.successor : positionY.predecessor
        return DoubleArrayPosition(positionX: positionX, positionY: adjustedPositionY)
    }
    
    private func positionInNextRow(toLeft: Bool, inGameBoard gameBoard: GameBoard) -> DoubleArrayPosition {
        let toRowCount = gameBoard.pieces[positionY.successor].count
        return position(toRowCount: toRowCount, toLeft: toLeft, toNextRow: true, inGameBoard: gameBoard)
    }
    
    private func positionInPreviousRow(toLeft: Bool, inGameBoard gameBoard: GameBoard) -> DoubleArrayPosition {
        let toRowCount = gameBoard.pieces[positionY.predecessor].count
        return position(toRowCount: toRowCount, toLeft: toLeft, toNextRow: false, inGameBoard: gameBoard)
    }
}
