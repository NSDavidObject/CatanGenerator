//
//  PortView.swift
//  Catan
//
//  Created by David Elsonbaty on 8/25/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import UIKit

class PortView: UIView {
    
    var port: Port? {
        didSet { didUpdatePort() }
    }
    
    let imageView: UIImageView = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.frame = bounds
        imageView.contentMode = .scaleAspectFill
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        imageView.layer.shouldRasterize = true
        imageView.layer.rasterizationScale = UIScreen.main.scale
        addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func didUpdatePort() {
        imageView.image = port?.image
    }
}

extension Port {
    var image: UIImage {
        switch self {
        case .wild: return #imageLiteral(resourceName: "port-wild")
        case .resource(let resource):
            switch resource {
            case .clay: return #imageLiteral(resourceName: "port-clay")
            case .hay: return #imageLiteral(resourceName: "port-hay")
            case .sheep: return #imageLiteral(resourceName: "port-sheep")
            case .stone: return #imageLiteral(resourceName: "port-stone")
            case .wood: return #imageLiteral(resourceName: "port-wood")
            case .gold: fatalError()
            }
        }
    }
}
