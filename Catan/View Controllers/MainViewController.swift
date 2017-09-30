//
//  MainViewController.swift
//  Catan
//
//  Created by David Elsonbaty on 8/19/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    static let launchAnimationDuration: TimeInterval = 0.8
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var boardView: BoardView!
    @IBOutlet weak var generateButton: TransformableButton!
    @IBOutlet weak var gameTypeToggleButton: TransformableButton!
    
    var gameType: GameType = .classic {
        didSet { didUpdateCurrentGameType() }
    }
    
    fileprivate var areProbabilityTokensEnabled: Bool = true
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        boardView.backgroundColor = .clear
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapGameBoardView))
        boardView.addGestureRecognizer(gestureRecognizer)
        
        generateButton.layer.borderWidth = 1.0
        generateButton.layer.borderColor = UIColor.appColorMainColor.cgColor
        
        generateButton.clickSound = .click
        generateButton.feedbackType = .selection
        generateButton.proportionalCornerRadius = .circular
        generateButton.setTitle("Generate", for: .normal)
        generateButton.setTitleColor(UIColor.appColorMainViewControllerGenerateButton, for: .normal)
        generateButton.titleLabel?.font = UIFont.appFontMainViewControllerGenerateButton
        
        gameTypeToggleButton.clickSound = .toggle
        gameTypeToggleButton.feedbackType = .success
        gameTypeToggleButton.titleLabel?.font = UIFont.appFontMainViewControllerGameTypeTitleLabel
        gameTypeToggleButton.setTitleColor(UIColor.appColorMainViewControllerGameTypeTitleLabel, for: .normal)
        
        didUpdateCurrentGameType()
        updateSubviewsAlpha(to: 0.0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let randomSubview = contentView.subviews.first, randomSubview.alpha == 0.0 {
            updateSubviewsAlphaWithAnimation(to: 1.0, animated: true)
        }
    }
    
    @IBAction func generateButtonClicked(_ sender: Any) {
        generateGameBoard()
    }
    
    @IBAction func gameTypeToggleButtonClicked(_ sender: Any) {
        gameType = gameType.nextGameType
    }
    
    @objc func didTapGameBoardView() {
        areProbabilityTokensEnabled = !areProbabilityTokensEnabled
        boardView.toggleProbabilityTokens(on: areProbabilityTokensEnabled, animated: true)
    }
    
    func didUpdateCurrentGameType() {
        generateGameBoard()
        
        UIView.performWithoutAnimation { [weak self] in
            self?.gameTypeToggleButton.setTitle(gameType.name, for: .normal)
            self?.gameTypeToggleButton.layoutIfNeeded()
        }
    }
    
    func generateGameBoard() {
        let gameBoard = GameBoardFactory.fairlyDistributedGameBoard(ofType: gameType)
        boardView.setup(with: gameBoard)
    }
    
    func updateSubviewsAlpha(to alpha: CGFloat) {
        contentView.subviews.forEach({ $0.alpha = alpha })
    }
    
    func updateSubviewsAlphaWithAnimation(to alpha: CGFloat, animated: Bool) {
        UIView.animate(withDuration: MainViewController.launchAnimationDuration) { [weak self] in
            self?.updateSubviewsAlpha(to: alpha)
        }
    }
}

