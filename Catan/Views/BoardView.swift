//
//  BoardView.swift
//  Catan
//
//  Created by David Elsonbaty on 8/23/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import UIKit

class BoardView: UIView {
    
    private var gameBoard: GameBoard? = nil
    private var gameBoardViews: [UIView] = []
    private var builtBoardOnViewWidth: CGFloat = 0.0
    
    func setup(with gameBoard: GameBoard, showingProbabilityTokens: Bool) {
        self.gameBoard = gameBoard
        buildBoard()
        toggleProbabilityTokens(on: showingProbabilityTokens, animated: false)
    }
    
    func toggleProbabilityTokens(on: Bool, animated: Bool) {
        let hexagonsViews: [HexagonView] = gameBoardViews.flatMap({ $0 as? HexagonView })
        func toggleAlphaOfHexagonViews() {
            hexagonsViews.forEach({ hexagonView in
                hexagonView.diceCombinationTokenView.alpha = on ? 1.0 : 0.0
            })
        }
        
        if animated {
            UIView.animate(withDuration: 0.3, animations: {
                toggleAlphaOfHexagonViews()
            })
        } else {
            toggleAlphaOfHexagonViews()
        }
    }
    
    private func buildBoard() {
        guard let gameBoard = gameBoard else { return }
        
        // Reset old views
        gameBoardViews.forEach({ $0.removeFromSuperview() })
        gameBoardViews.removeAll()
        
        let numberOfSlotsPerRow = gameBoard.maxNumberOfHexagonsInRow
        let numberOfSlotsToAccountForInRow = numberOfSlotsPerRow.predecessor
        let viewWidth = frame.width
        
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
                gameBoardViews.append(view)
                originX += hexagonWidth + 0.5
            }
            originY += hexagonHeight * 0.75 + 0.5
        }
        
        builtBoardOnViewWidth = viewWidth
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard gameBoardViews.count == 0 || (builtBoardOnViewWidth != frame.width) else { return }
        buildBoard()
    }
    
    private func view(forPiece piece: GameBoardPiece) -> UIView {
        switch piece {
        case .hexagon(let hexagon):
            let hexagonView: HexagonView = HexagonView()
            hexagonView.hexagon = hexagon
            return hexagonView
        case .water(let water):
            let waterView: WaterView = WaterView()
            waterView.water = water
            return waterView
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
