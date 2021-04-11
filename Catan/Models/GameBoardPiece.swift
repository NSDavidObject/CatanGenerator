import Foundation

enum GameBoardPiece {
  
  enum Water {
    case plain
    case port(Port, location: Port.Location)
    
    var port: (Port, location: Port.Location)? {
      switch self {
      case .port(let port, location: let location): return (port, location)
      default: return nil
      }
    }
  }
  
  enum Hexagon {
    case theif
    case water
    case resource(Resource, value: DiceCombination)
    
    var diceCombination: DiceCombination? {
      switch self {
      case .resource(_, value: let diceCombination): return diceCombination
      default: return nil
      }
    }
    
    var resource: Resource? {
      switch self {
      case .resource(let resource, _): return resource
      default: return nil
      }
    }
    
    var isGoldWithHighProbability: Bool {
      if case .resource(let resource, value: let diceCombination) = self {
        return resource == .gold && diceCombination.probability.isHighest
      }
      return false
    }
  }
  
  var hexagon: Hexagon? {
    switch self {
    case .fog(let hexagon): return hexagon
    case .hexagon(let hexagon): return hexagon
    default: return nil
    }
  }
  
  var isHexagon: Bool {
    return (hexagon != nil)
  }
  
  var isOfHighestProbability: Bool {
    return hexagon?.diceCombination?.probability.isHighest ?? false
  }
  
  case empty
  case fog(Hexagon)
  case water(Water)
  case hexagon(Hexagon)
  case port(Port, location: Port.Location)
}

extension GameBoardPiece: Equatable {
  
  static func ==(lhs: GameBoardPiece, rhs: GameBoardPiece) -> Bool {
    switch (lhs, rhs) {
    case (.port(let lhsPort, location: _), .port(let rhsPort, location: _)):
      return lhsPort == rhsPort
    case (.hexagon(let lhsHexagon), .hexagon(let rhsHexagon)):
      return lhsHexagon == rhsHexagon
    case (.empty, .empty):
      return true
    default:
      return false
    }
  }
}

extension GameBoardPiece.Hexagon: Equatable {
  static func ==(lhs: GameBoardPiece.Hexagon, rhs: GameBoardPiece.Hexagon) -> Bool {
    switch (lhs, rhs) {
    case (.theif, .theif):
      return true
    case (.resource(let lhsResource, let lhsDiceCombination), .resource(let rhsResource, let rhsDiceCombination)):
      return lhsResource == rhsResource && lhsDiceCombination == rhsDiceCombination
    default:
      return false
    }
  }
}
