import Foundation

enum GameType {
  case classic
  case extendedClassic
  case seafarers(scenario: SeafarersScenario)
  
  var name: String {
    switch self {
    case .classic: return "Classic Game"
    case .extendedClassic: return "Classic Game with Extension"
    case .seafarers(let scenario): return "Seafarers - \(scenario.name)"
    }
  }
  
  var definition: GameDefinition.Type {
    switch self {
    case .classic: return ClassicGame.self
    case .extendedClassic: return ExtendedClassicGame.self
    case .seafarers(let scenario): return scenario.definition
    }
  }
  
  var nextGameType: GameType {
    return GameType(rawValue: rawValue + 1) ?? (GameType(rawValue: 0) ?? self)
  }
  
  init?(rawValue: Int) {
    guard let type = GameType.gameType(forRawValue: rawValue) else { return nil }
    self = type
  }
}

extension GameType {
  
  var rawValue: Int {
    switch self {
    case .classic: return 0
    case .extendedClassic: return 1
    case .seafarers(scenario: let scenario):
      switch scenario {
      case .headingForTheShores3Players: return 2
      case .headingForTheShores4Players: return 3
      case .headingForTheFogyShores3Players: return 4
      case .headingForTheFogyShores4Players: return 5
      case .theFogIslands3Players: return 6
      case .theFogIslands4Players: return 7
      }
    }
  }
  
  static func gameType(forRawValue rawValue: Int) -> GameType? {
    switch rawValue {
    case 0: return .classic
    case 1: return .extendedClassic
    case 2: return .seafarers(scenario: .headingForTheShores3Players)
    case 3: return .seafarers(scenario: .headingForTheShores4Players)
    case 4: return .seafarers(scenario: .headingForTheFogyShores3Players)
    case 5: return .seafarers(scenario: .headingForTheFogyShores4Players)
    case 6: return .seafarers(scenario: .theFogIslands3Players)
    case 7: return .seafarers(scenario: .theFogIslands4Players)
    default: return nil
    }
  }
}
