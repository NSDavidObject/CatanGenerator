//
//  GameBoard.swift
//  Catan
//
//  Created by David Elsonbaty on 8/19/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import Foundation

struct GameBoard {
    
    let pieces: [[GameBoardPiece]]
    let maxNumberOfHexagonsInRow: Int
    
    init(pieces: [[GameBoardPiece]]) {
        self.pieces = pieces
        maxNumberOfHexagonsInRow = GameBoard.maxNumberOfHexagonsInRow(in: pieces)
    }
    
    static func maxNumberOfHexagonsInRow(in pieces: [[GameBoardPiece]]) -> Int {
        return pieces.reduce(0) { (result, pieces) -> Int in
            return max(result, pieces.count)
        }
    }
}

extension GameBoard {
    
    func isEvenlySetup() -> Bool {
        guard areRowsEvenlyPlaced() && areDownRightEvenlyPlaced() && areDownLeftEvenlyPlaced() else { return false }
        return true
    }
    
    private func areRowsEvenlyPlaced() -> Bool {
        for row in pieces where !isListEvenlyPlaced(list: row) {
            return false
        }
        return true
    }
    
    private func areDownLeftEvenlyPlaced() -> Bool {
        for (rowIndex, row) in pieces.enumerated() {
            guard rowIndex < (pieces.count - 1) else { continue }
            for (itemIndex, item) in row.enumerated() {
                let nextRow = pieces[rowIndex + 1]
                let leftIndex = itemIndex - ((row.count < nextRow.count) ? 0 : 1)
                if item.isOfHighestProbability && (nextRow[safe: leftIndex]?.isOfHighestProbability).value  {
                    return false
                }
            }
        }
        return true
    }
    
    private func areDownRightEvenlyPlaced() -> Bool {
        for (rowIndex, row) in pieces.enumerated() {
            guard rowIndex < (pieces.count - 1) else { continue }
            for (itemIndex, item) in row.enumerated() {
                let nextRow = pieces[rowIndex + 1]
                let rightIndex = itemIndex + ((row.count < nextRow.count) ? 1 : 0)
                if item.isOfHighestProbability && (nextRow[safe: rightIndex]?.isOfHighestProbability).value  {
                    return false
                }
            }
        }
        return true
    }
    
    private func isListEvenlyPlaced(list: [GameBoardPiece]) -> Bool {
        var isLastItemOfHighestProbability = false
        for item in list {
            let isCurrentItemOfHighestProbability = item.isOfHighestProbability
            if isLastItemOfHighestProbability && isCurrentItemOfHighestProbability {
                return false
            }
            isLastItemOfHighestProbability = isCurrentItemOfHighestProbability
        }
        return true
    }
}

