import Foundation

enum SeafarersScenario {
  case headingForTheShores3Players
  case headingForTheShores4Players
  case headingForTheFogyShores3Players
  case headingForTheFogyShores4Players
  case theFogIslands3Players
  case theFogIslands4Players
  
  var name: String {
    switch self {
    case .headingForTheShores3Players: return "Heading For The Shores (3P)"
    case .headingForTheShores4Players: return "Heading For The Shores (4P)"
    case .headingForTheFogyShores3Players: return "Heading For The Fogy Shores (3P)"
    case .headingForTheFogyShores4Players: return "Heading For The Fogy Shores (4P)"
    case .theFogIslands3Players: return "The Fog Islands (3P)"
    case .theFogIslands4Players: return "The Fog Islands (4P)"
    }
  }
  
  var definition: GameDefinition.Type {
    switch self {
    case .headingForTheShores3Players: return HeadingForTheShores3PlayersGameDefinition.self
    case .headingForTheShores4Players: return HeadingForTheShores4PlayersGameDefinition.self
    case .headingForTheFogyShores3Players: return HeadingForTheFogyShores3PlayersGameDefinition.self
    case .headingForTheFogyShores4Players: return HeadingForTheFogyShores4PlayersGameDefinition.self
    case .theFogIslands3Players: return TheFogIslands3PlayersGameDefinition.self
    case .theFogIslands4Players: return TheFogIslands4PlayersGameDefinition.self
    }
  }
}
