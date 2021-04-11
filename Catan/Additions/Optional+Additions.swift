import Foundation

extension Optional {
  
  func apply(_ closure: (Wrapped) -> Void) {
    if case .some(let value) = self {
      closure(value)
    }
  }
}

extension Optional where Wrapped == Bool {
  var value: Bool {
    return self ?? false
  }
}
