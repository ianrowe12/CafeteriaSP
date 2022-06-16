
import UIKit

class Haptics {
    static func errorVibration() {
        let vibrationGenerator = UINotificationFeedbackGenerator()
        vibrationGenerator.prepare()
        vibrationGenerator.notificationOccurred(.error)
    }
    static func successVibration() {
        let vibrationGenerator = UINotificationFeedbackGenerator()
        vibrationGenerator.prepare()
        vibrationGenerator.notificationOccurred(.success)
    }
    static func warningVibration() {
        let vibrationGenerator = UINotificationFeedbackGenerator()
        vibrationGenerator.prepare()
        vibrationGenerator.notificationOccurred(.warning)
    }
    static func selectionVibration() {
        let vibrationGenerator = UISelectionFeedbackGenerator()
        vibrationGenerator.prepare()
        vibrationGenerator.selectionChanged()
    }
    static func impactVibration() {
        let vibrationGenerator = UINotificationFeedbackGenerator()
        vibrationGenerator.prepare()
        vibrationGenerator.notificationOccurred(.error)
    }
}
