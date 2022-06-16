
import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat { //IB inspectable allows us to view this property from the storyBoard
        get{return cornerRadius}
        set{
            self.layer.cornerRadius = newValue
        }
    }
}
