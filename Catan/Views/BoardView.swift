//
//  BoardView.swift
//  Catan
//
//  Created by David Elsonbaty on 8/23/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import UIKit
import CommonUtilities

class BoardView: UIView {
    
    private(set) var gameBoard: GameBoard? = nil
    private var gameBoardViews: [UIView] = []
    private var builtBoardOnViewWidth: CGFloat = 0.0
    
    func setup(with gameBoard: GameBoard, showingProbabilityTokens: Bool) {
        self.gameBoard = gameBoard
        buildBoard()
        toggleProbabilityTokens(on: showingProbabilityTokens, animated: false)
    }
    
    func toggleProbabilityTokens(on: Bool, animated: Bool) {
        let hexagonsViews: [HexagonView] = gameBoardViews.filter(ofClass: HexagonView.self)
        func toggleAlphaOfHexagonViews() {
            hexagonsViews.forEach({ $0.toggleDiceCombinationVisibility(toVisible: on) })
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
        
        let viewWidth = frame.width
        let numberOfSlotsPerRow: CGFloat = CGFloat(gameBoard.maxNumberOfHexagonsInRow)
        
        let areAllRowsOfSameSize = gameBoard.pieces.reduce(Set<Int>()) { (result, pieces) -> Set<Int> in
            var res = result
            res.insert(pieces.count)
            return res
            }.count == 1
        
        let numberOfSlotsToAccountForInRow: CGFloat = areAllRowsOfSameSize ? (numberOfSlotsPerRow + 0.5) : numberOfSlotsPerRow
        let hexagonWidth = viewWidth / numberOfSlotsToAccountForInRow.predecessor
        let hexagonHeight = hexagonWidth * 70/61
        let hexagonSize = CGSize(width: hexagonWidth, height: hexagonHeight)
        let saparator = (1/UIScreen.main.scale)
        
        var originY: CGFloat = 0.0
        for (rowNumber, row) in gameBoard.pieces.enumerated() {
            let numberOfSlotsInRow = CGFloat(row.count)
            let numberOfSlotsLessThanMax = numberOfSlotsToAccountForInRow - numberOfSlotsInRow
            var originX: CGFloat = -hexagonWidth.half

            if !areAllRowsOfSameSize {
                originX += ((numberOfSlotsLessThanMax * hexagonWidth) + (numberOfSlotsLessThanMax - 1) * 0.5) / 2
            } else {
                originX += (rowNumber % 2 == 0) ? 0.0 : (hexagonWidth * 0.5)
            }
            
            for piece in row {
                let origin = CGPoint(x: originX, y: originY)
                let view: UIView = self.view(forPiece: piece)
                view.frame = CGRect(origin: origin, size: hexagonSize)
                addSubview(view)
                gameBoardViews.append(view)
                originX += hexagonWidth + saparator
            }
            originY += hexagonHeight * 0.75 + saparator
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
        case .fog(let hexagon):
            let fogView: FogView = FogView()
            fogView.hexagon = hexagon
            return fogView
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
