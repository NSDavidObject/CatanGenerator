import Foundation

struct GameBoardDistributionAdjacentResourcesRule: GameBoardDistributionRule {
  static func isHexagonValid(_ hexagon: GameBoardPiece.Hexagon, withAdjacentHexagons neighbors: [GameBoardPiece.Hexagon]) -> Bool {
    guard let resource = hexagon.resource, neighbors.count > 0 else { return true }
    
    if neighbors.allPass({ $0.resource != resource }) {
      print(neighbors.compactMap({ $0.resource?.debugDescription }), hexagon.resource!.debugDescription)
      return true
    }
    
    return neighbors.allPass({ $0.resource != resource })
  }
}

struct GameBoardDistributionAdjacentGoldResourcesRule: GameBoardDistributionRule {
  static func isHexagonValid(_ hexagon: GameBoardPiece.Hexagon, withAdjacentHexagons neighbors: [GameBoardPiece.Hexagon]) -> Bool {
    guard let resource = hexagon.resource, resource == .gold else { return true }
    return neighbors.allPass({ $0.resource != resource })
  }
}
