//
//  BoardView.swift
//  Catan
//
//  Created by David Elsonbaty on 8/23/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import UIKit

class BoardView: UIView {
    
    var gameBoard: GameBoard? = nil
    func setup(with gameBoard: GameBoard) {
        self.gameBoard = gameBoard
        buildBoard()
    }
    
    func buildBoard() {
        guard let gameBoard = gameBoard else { return }
        
        // Reset old views
        subviews.forEach({ $0.removeFromSuperview() })
        
        let numberOfSlotsPerRow = gameBoard.maxNumberOfHexagonsInRow
        let numberOfSlotsToAccountForInRow = numberOfSlotsPerRow - 1
        let viewWidth = UIScreen.main.bounds.width - 30
        
        let hexagonWidth = viewWidth / CGFloat(numberOfSlotsToAccountForInRow)
        let hexagonHeight = hexagonWidth * 70/61
        let hexagonSize = CGSize(width: hexagonWidth, height: hexagonHeight)

        var originY: CGFloat = 0.0
        for row in gameBoard.pieces {
            let numberOfSlotsInRow = row.count
            let numberOfSlotsLessThanMax = CGFloat(numberOfSlotsToAccountForInRow - numberOfSlotsInRow)
            var originX: CGFloat = ((numberOfSlotsLessThanMax * hexagonWidth) + (numberOfSlotsLessThanMax - 1) * 0.5) / 2
            for piece in row {
                let origin = CGPoint(x: originX, y: originY)
                let view: UIView = self.view(forPiece: piece)
                view.frame = CGRect(origin: origin, size: hexagonSize)
                addSubview(view)
                originX += hexagonWidth + 0.5
            }
            originY += hexagonHeight * 0.75 + 0.5
        }
    }
    
    func view(forPiece piece: GameBoardPiece) -> UIView {
        switch piece {
        case .hexagon(let hexagon):
            let hexagonView: HexagonView = HexagonView()
            hexagonView.hexagon = hexagon
            return hexagonView
        case .port(let port, location: let location):
            let portContainerView = PortContainerView()
            portContainerView.portView.port = port
            portContainerView.location = location
            return portContainerView
        default:
            return UIView()
        }
    }
}
