import UIKit

class TransformableButton: Button {
  
  var shouldTransformOnClick = true
  override var isHighlighted: Bool {
    didSet {
      if isHighlighted {
        alpha = 0.9
        if (shouldTransformOnClick) {
          transform = CGAffineTransform(scaleX: 0.99, y: 0.99)
        }
      } else {
        alpha = 1.0
        isEnabled = isEnabled
        if (shouldTransformOnClick) {
          transform = .identity
        }
      }
    }
  }
  
  override func commonInitalization() {
    super.commonInitalization()
    
    adjustsImageWhenHighlighted = false
  }
}
