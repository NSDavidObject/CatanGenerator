//
//  ShareImageViewController.swift
//  Catan
//
//  Created by David Elsonbaty on 7/7/18.
//  Copyright © 2018 David Elsonbaty. All rights reserved.
//

import UIKit
import CommonUtilities

class ShareImageView: View {

  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var boardView: BoardView!
  @IBOutlet var mainStackView: UIStackView!
  @IBOutlet var backgroundImageView: ImageView!

  override func awakeFromNib() {
    super.awakeFromNib()

    titleLabel.numberOfLines = 2
    titleLabel.textAlignment = .center
    titleLabel.text = "Catanous\nCatan Generator"

    proportionalCornerRadius = .constant(20.0)
  }

  func setup(withGameBoard gameBoard: GameBoard) {
    boardView.setup(with: gameBoard, showingProbabilityTokens: true)
  }
}

extension ShareImageView {

  static func shareImage(for gameBoard: GameBoard, completion: @escaping ((UIImage) -> Void)) {

    let shareImageView: ShareImageView = ShareImageView.instanceFromNib()
    shareImageView.setup(withGameBoard: gameBoard)

//    DispatchQueue.global().async {
      let screenshot = shareImageView.screenshot()
      let resizedScreenshot = screenshot?.resize(toSize: CGSize(width: 360, height: 470))
      guard let nonOptionalScreenshot = resizedScreenshot else { fatalError() }
//        DispatchQueue.main.async {
          completion(nonOptionalScreenshot)
//      }
//    }
  }
}
