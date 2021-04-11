import Foundation

struct GameBoardProbabilityDistributionFairnessEvaluator: GameBoardFairnessEvaluator {
  
  static func isGameBoardFairlySetup(_ gameBoard: GameBoard) -> Bool {
    return areRowsEvenlyPlaced(in: gameBoard) && areDownRightEvenlyPlaced(in: gameBoard) && areDownLeftEvenlyPlaced(in: gameBoard)
  }
  
  private static func areRowsEvenlyPlaced(in gameBoard: GameBoard) -> Bool {
    for row in gameBoard.pieces where !isListEvenlyPlaced(list: row) {
      return false
    }
    return true
  }
  
  private static func areDownLeftEvenlyPlaced(in gameBoard: GameBoard) -> Bool {
    for (rowIndex, row) in gameBoard.pieces.enumerated() {
      guard rowIndex < (gameBoard.pieces.count - 1) else { continue }
      for (itemIndex, item) in row.enumerated() {
        let nextRow = gameBoard.pieces[rowIndex + 1]
        let leftIndex = itemIndex - ((row.count < nextRow.count) ? 0 : 1)
        if item.isOfHighestProbability && (nextRow[safe: leftIndex]?.isOfHighestProbability).value  {
          return false
        }
      }
    }
    return true
  }
  
  private static func areDownRightEvenlyPlaced(in gameBoard: GameBoard) -> Bool {
    for (rowIndex, row) in gameBoard.pieces.enumerated() {
      guard rowIndex < (gameBoard.pieces.count - 1) else { continue }
      for (itemIndex, item) in row.enumerated() {
        let nextRow = gameBoard.pieces[rowIndex + 1]
        let rightIndex = itemIndex + ((row.count < nextRow.count) ? 1 : 0)
        if item.isOfHighestProbability && (nextRow[safe: rightIndex]?.isOfHighestProbability).value  {
          return false
        }
      }
    }
    return true
  }
  
  private static func isListEvenlyPlaced(list: [GameBoardPiece]) -> Bool {
    var isLastItemOfHighestProbability = false
    for item in list {
      let isCurrentItemOfHighestProbability = item.isOfHighestProbability
      if isLastItemOfHighestProbability && isCurrentItemOfHighestProbability {
        return false
      }
      isLastItemOfHighestProbability = isCurrentItemOfHighestProbability
    }
    return true
  }
}
