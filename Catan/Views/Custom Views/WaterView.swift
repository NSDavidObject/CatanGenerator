import UIKit

class WaterView: UIView {
  
  var water: GameBoardPiece.Water? {
    didSet { didUpdateWater() }
  }
  
  let imageView: UIImageView = UIImageView(image: #imageLiteral(resourceName: "hexagon-water"))
  let portContainerView: PortContainerView = PortContainerView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    imageView.frame = bounds
    imageView.contentMode = .scaleAspectFill
    imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    addSubview(imageView)
    
    portContainerView.frame = bounds
    portContainerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    addSubview(portContainerView)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func didUpdateWater() {
    guard let water = water else { return }
    
    portContainerView.isHidden = (water.port == nil)
    guard let portInfo = water.port else { return }
    
    portContainerView.portView.port = portInfo.0
    portContainerView.location = portInfo.location
  }
}
