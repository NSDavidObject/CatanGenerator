import Foundation

extension Int {
  
  var successor: Int {
    return self + 1
  }
  
  var predecessor: Int {
    return self - 1
  }
  
  init(_ bool: Bool) {
    self = bool ? 1 : 0
  }
  
  func map<T>(from start: Int = 0, _ transform: ((Int) throws -> T), ascending: Bool = true) rethrows -> [T] {
    if ascending {
      return try (start..<self).map(transform)
    } else {
      return try (start..<self).reversed().map(transform)
    }
  }
}
