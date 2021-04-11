import Foundation

protocol GameBoardFairnessEvaluator {
  static func isGameBoardFairlySetup(_ gameBoard: GameBoard) -> Bool
}
