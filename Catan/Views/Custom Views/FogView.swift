import UIKit

private struct Constants {
  static let showsFog: Bool = true
}

class FogView: HexagonView {
  
  let fogImageView: UIImageView = UIImageView(image: #imageLiteral(resourceName: "hexagon-fog"))
  private var isShowingFog: Bool = true
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    fogImageView.frame = bounds
    fogImageView.contentMode = .scaleAspectFill
    fogImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    addSubview(fogImageView)
    
    let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(didLongPressFog))
    addGestureRecognizer(gestureRecognizer)
  }
  
  override func didUpdateHexagon() {
    super.didUpdateHexagon()
    
    if Constants.showsFog {
      fogImageView.alpha = 1.0
      imageView.alpha = 0.0
      diceCombinationTokenView.alpha = 0.0
    } else {
      fogImageView.alpha = 0.0
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func changeDiceCombinationAlpha() {
    guard !Constants.showsFog || !isShowingFog else { return }
    super.changeDiceCombinationAlpha()
  }
  
  @objc func didLongPressFog() {
    guard Constants.showsFog else { return }
    
    isShowingFog = false
    UIView.animate(withDuration: 0.3) {
      self.fogImageView.alpha = 0.0
      self.imageView.alpha = 1.0
      self.changeDiceCombinationAlpha()
    }
  }
}
