import Foundation

public extension UserDefaults {
    
    func optionalBool(forKey defaultName: String) -> Bool? {
        guard let _ = object(forKey: defaultName) else { return nil }
        return bool(forKey: defaultName)
    }
    
    func optionalInteger(forKey defaultName: String) -> Int? {
        guard let _ = object(forKey: defaultName) else { return nil }
        return integer(forKey: defaultName)
    }
}
