
import Foundation

extension UserDefaults {
    enum userDefaultsKeys: String {
        case notfirsTime
    }
    
    var notFirstTime: Bool {
        get {
            bool(forKey: userDefaultsKeys.notfirsTime.rawValue)
        }
        
        set {
            setValue(newValue, forKey: userDefaultsKeys.notfirsTime.rawValue)
        }
    }
}
