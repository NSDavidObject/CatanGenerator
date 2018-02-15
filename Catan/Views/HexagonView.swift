//
//  HexagonView.swift
//  Catan
//
//  Created by David Elsonbaty on 8/23/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import UIKit

class WaterView: UIView {
    
    var water: GameBoardPiece.Water? {
        didSet { didUpdateWater() }
    }
    
    let imageView: UIImageView = UIImageView(image: #imageLiteral(resourceName: "hexagon-knight"))
    let portContainerView: PortContainerView = PortContainerView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.image = #imageLiteral(resourceName: "hexagon-water")
        imageView.alpha = 0.2
        imageView.frame = bounds
        imageView.contentMode = .scaleAspectFill
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(imageView)
        
        portContainerView.frame = bounds
        portContainerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(portContainerView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func didUpdateWater() {
        guard let water = water else { return }
        
        portContainerView.isHidden = (water.port == nil)
        guard let portInfo = water.port else { return }
        
        portContainerView.portView.port = portInfo.0
        portContainerView.location = portInfo.location
    }
}

class HexagonView: UIView {
    
    var hexagon: GameBoardPiece.Hexagon? {
        didSet { didUpdateHexagon() }
    }
    
    let diceCombinationTokenView: DiceCombinationTokenView = DiceCombinationTokenView()
    let imageView: UIImageView = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.frame = bounds
        imageView.contentMode = .scaleAspectFill
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(imageView)
        addSubview(diceCombinationTokenView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let tokenViewToHexagonViewAspectSize: CGFloat = 28/61
        let tokenViewWidth: CGFloat = bounds.width * tokenViewToHexagonViewAspectSize
        diceCombinationTokenView.frame = CGRect(x: (bounds.width - tokenViewWidth) / 2, y: (bounds.height - tokenViewWidth) / 2, width: tokenViewWidth, height: tokenViewWidth)
    }
    
    func didUpdateHexagon() {
        guard let hexagon = hexagon else { return }
        imageView.image = hexagon.image
        
        if case .resource(_, let diceCombination) = hexagon {
            diceCombinationTokenView.diceCombination = diceCombination
        }
    }
}

extension GameBoardPiece.Hexagon {
    
    var image: UIImage {
        switch self {
        case .theif: return #imageLiteral(resourceName: "hexagon-knight")
        case .resource(let resource, value: _):
            switch resource {
            case .clay: return #imageLiteral(resourceName: "hexagon-clay")
            case .hay: return #imageLiteral(resourceName: "hexagon-hay")
            case .sheep: return #imageLiteral(resourceName: "hexagon-sheep")
            case .stone: return #imageLiteral(resourceName: "hexagon-stone")
            case .wood: return #imageLiteral(resourceName: "hexagon-wood")
            case .gold: return #imageLiteral(resourceName: "hexagon-gold")
            }
        }
    }
}

