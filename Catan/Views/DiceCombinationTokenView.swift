//
//  DiceCombinationTokenView.swift
//  Catan
//
//  Created by David Elsonbaty on 8/25/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import UIKit

class DiceCombinationTokenView: UIView {
    
    var diceCombination: DiceCombination? {
        didSet { didUpdateDiceCombination() }
    }
    
    let imageView: UIImageView = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.frame = bounds
        imageView.contentMode = .scaleAspectFill
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func didUpdateDiceCombination() {
        guard let diceCombination = diceCombination else { return }
        imageView.image = diceCombination.image
    }
}

extension DiceCombination {
    
    var image: UIImage {
        switch self {
        case .two: return #imageLiteral(resourceName: "value-token-2")
        case .three: return #imageLiteral(resourceName: "value-token-3")
        case .four: return #imageLiteral(resourceName: "value-token-4")
        case .five: return #imageLiteral(resourceName: "value-token-5")
        case .six: return #imageLiteral(resourceName: "value-token-6")
        case .eight: return #imageLiteral(resourceName: "value-token-8")
        case .nine: return #imageLiteral(resourceName: "value-token-9")
        case .ten: return #imageLiteral(resourceName: "value-token-10")
        case .eleven: return #imageLiteral(resourceName: "value-token-11")
        case .twelve: return #imageLiteral(resourceName: "value-token-12")
        }
    }
}
