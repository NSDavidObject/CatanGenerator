//
//  GameBoard.swift
//  Catan
//
//  Created by David Elsonbaty on 8/19/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import Foundation

struct GameBoard {
    
    let type: GameType
    let pieces: [[GameBoardPiece]]
    let maxNumberOfHexagonsInRow: Int
    
    init(type: GameType, pieces: [[GameBoardPiece]]) {
        self.type = type
        self.pieces = pieces
        maxNumberOfHexagonsInRow = GameBoard.maxNumberOfHexagonsInRow(in: pieces)
    }
    
    static func maxNumberOfHexagonsInRow(in pieces: [[GameBoardPiece]]) -> Int {
        return pieces.reduce(0) { (result, pieces) -> Int in
            return max(result, pieces.count)
        }
    }
}
