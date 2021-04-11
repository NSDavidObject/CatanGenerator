import UIKit

class PortContainerView: UIView {
  
  private static let portViewAspectRatio: CGFloat = 27.0/35.0
  private static let portViewToContainerViewWidthAspectSize: CGFloat = 35.0/61.0
  
  let portView: PortView = PortView()
  var location: Port.Location?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(portView)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    let portViewWidth: CGFloat = bounds.width * PortContainerView.portViewToContainerViewWidthAspectSize
    let portViewHeight: CGFloat = portViewWidth * PortContainerView.portViewAspectRatio
    portView.frame = CGRect(x: 0, y: 0, width: portViewWidth, height: portViewHeight)
    location.apply {
      setupPortInLocation($0)
    }
  }
  
  func setupPortInLocation(_ location: Port.Location) {
    switch location {
    case .left:
      pinPortToLeft()
    case .right:
      pinPortToRight()
    case .bottomRight:
      pinPortToBottomRight()
    case .bottomLeft:
      pinPortToBottomLeft()
    case .topLeft:
      pinPortToTopLeft()
    case .topRight:
      pinPortToTopRight()
    }
  }
}

extension PortContainerView {
  
  func pinPortToLeft() {
    let portSize = portView.bounds.size
    portView.frame = CGRect(origin: CGPoint(x: bounds.width - portSize.width, y: bounds.height / 2 - portSize.height / 2), size: portSize)
    
    let angle = CGFloat.pi/2
    portView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    portView.transform = CGAffineTransform(rotationAngle: angle)
    
    let originXAdjustment: CGFloat = -portView.frame.minX
    portView.transform = portView.transform.concatenating(.init(translationX: originXAdjustment, y: 0))
  }
  
  func pinPortToRight() {
    let portSize = portView.bounds.size
    portView.frame = CGRect(origin: CGPoint(x: bounds.width - portSize.width, y: bounds.height / 2 - portSize.height / 2), size: portSize)
    
    let angle = -(CGFloat.pi/2)
    portView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    portView.transform = CGAffineTransform(rotationAngle: angle)
    
    let originXAdjustment: CGFloat = (bounds.size.width - portView.frame.maxX)
    portView.transform = portView.transform.concatenating(.init(translationX: originXAdjustment, y: 0))
  }
  
  func pinPortToBottomRight() {
    let portSize = portView.bounds.size
    portView.frame = CGRect(origin: CGPoint(x: bounds.width - portSize.width, y: bounds.height - portSize.height), size: portSize)
    
    portView.layer.anchorPoint = CGPoint(x: 1, y: 1)
    portView.transform = CGAffineTransform(rotationAngle: -.pi/6)
    
    let originXAdjustment: CGFloat = (bounds.size.width - portView.frame.maxX)
    let originYAdjustment: CGFloat = (bounds.size.height - portView.frame.maxY)
    portView.transform = portView.transform.concatenating(.init(translationX: originXAdjustment, y: originYAdjustment))
  }
  
  func pinPortToBottomLeft() {
    let portSize = portView.bounds.size
    portView.frame = CGRect(origin: CGPoint(x: 0, y: bounds.height - portSize.height), size: portSize)
    
    portView.layer.anchorPoint = CGPoint(x: 1, y: 1)
    portView.transform = CGAffineTransform(rotationAngle: .pi/6)
    
    let originXAdjustment: CGFloat = -(portView.frame.minX)
    let originYAdjustment: CGFloat = (bounds.size.height - portView.frame.maxY)
    portView.transform = portView.transform.concatenating(.init(translationX: originXAdjustment, y: originYAdjustment))
  }
  
  func pinPortToTopLeft() {
    let portSize = portView.bounds.size
    portView.frame = CGRect(origin: .zero, size: portSize)
    
    portView.layer.anchorPoint = CGPoint(x: 1, y: 1)
    portView.transform = CGAffineTransform(rotationAngle: 5 * .pi/6)
    
    let originXAdjustment: CGFloat = -(portView.frame.minX)
    let originYAdjustment: CGFloat = -(portView.frame.minY)
    portView.transform = portView.transform.concatenating(.init(translationX: originXAdjustment, y: originYAdjustment))
  }
  
  func pinPortToTopRight() {
    let portSize = portView.bounds.size
    portView.frame = CGRect(origin: CGPoint(x: bounds.width - portSize.width, y: 0), size: portSize)
    
    portView.layer.anchorPoint = CGPoint(x: 1, y: 1)
    portView.transform = CGAffineTransform(rotationAngle: -5 * .pi/6)
    
    let originXAdjustment: CGFloat = (bounds.size.width - portView.frame.maxX)
    let originYAdjustment: CGFloat = -(portView.frame.minY)
    portView.transform = portView.transform.concatenating(.init(translationX: originXAdjustment, y: originYAdjustment))
  }
}
