import Foundation

extension Collection {
    
    public subscript(safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
    public func allPass(_ checker: (Iterator.Element) -> Bool) -> Bool {
        for element in self where !checker(element) {
            return false
        }
        return true
    }
}
