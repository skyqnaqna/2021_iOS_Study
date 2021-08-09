//
//  PlayingCardView.swift
//  PlayingCard
//
//  Created by Subin Kim on 2021/08/08.
//

import UIKit

class PlayingCardView: UIView {
  
  var rank: Int = 11 {
    didSet { // rank가 바뀌면 드로잉을 다시 함
      setNeedsDisplay() // drawRect를 직접 부를 수 없으므로 시스템에게 말해준다
      setNeedsLayout() // 오토레이아웃을 안쓴 서브뷰들을 재배치
    }
  }
  var suit: String = "❤️" { didSet { setNeedsDisplay(); setNeedsLayout() }}
  var isFaceUp: Bool = true { didSet { setNeedsDisplay(); setNeedsLayout() }}
  
  private func centeredAttributedString(_ string: String, fontSize: CGFloat) -> NSAttributedString {
    var font = UIFont.preferredFont(forTextStyle: .body).withSize(fontSize)
    font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font) // 아이폰 설정 -> 디스플레이 및 밝기 -> 텍스트 크기 -> 유동적 글자 크기 조절 지원
    
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .center
    
    return NSAttributedString(string: string, attributes: [NSAttributedString.Key.paragraphStyle:paragraphStyle, .font:font])
  }
  
  private var cornerString: NSAttributedString {
    return centeredAttributedString(rankString+"\n"+suit, fontSize: cornerFontSize)
  }
  
  private lazy var upperLeftCornerLabel = createCornerLabel()
  private lazy var lowerRightCornerLabel = createCornerLabel()
  
  private func createCornerLabel() -> UILabel {
    let label = UILabel()
    label.numberOfLines = 0 // 0으로 설정하면 줄 수를 원하는 대로 쓸 수 있음을 뜻함
    addSubview(label) // 서브뷰로 추가하지 않으면 드로잉을 하지 않기 때문에 존재하지도 않음
    return label
  }
  
  private func configureCornerLabel(_ label: UILabel) {
    label.attributedText = cornerString
    label.frame.size = CGSize.zero // sizeToFit을 하기 전에 크기 설정을 지움 -> 너비가 정해져 있으면 높이만 맞춰지기 때문
    label.sizeToFit() // 레이블의 크기를 내용에 맞춤
    label.isHidden = !isFaceUp
  }
  
  // 설정에서 폰트 크기나 폰의 경계(가로 세로)를 바꾸었을때 알려주는 함수
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    setNeedsDisplay()
    setNeedsLayout()
  }
  
  // 경계가 바뀔 때마다 해줘야 하는 일들을 수행
  // setNeedsLayout을 쓰면 시스템은 이 부분을 호출함
  // 사용자가 호출하는 것이 아닌, 시스템이 호출
  // setNeedsDisplay를 호출하면 시스템이 draw를 호출하는 것과 같음
  override func layoutSubviews() {
    super.layoutSubviews()
    
    configureCornerLabel(upperLeftCornerLabel)
    
    upperLeftCornerLabel.frame.origin = bounds.origin.offsetBy(dx: cornerOffset, dy: cornerOffset)
    
    configureCornerLabel(lowerRightCornerLabel)
    
    lowerRightCornerLabel.transform = CGAffineTransform.identity.translatedBy(x: lowerRightCornerLabel.frame.size.width, y: lowerRightCornerLabel.frame.size.height).rotated(by: CGFloat.pi)
    lowerRightCornerLabel.frame.origin = CGPoint(x: bounds.maxX, y: bounds.maxY).offsetBy(dx: -cornerOffset, dy: -cornerOffset).offsetBy(dx: -lowerRightCornerLabel.frame.size.width, dy: -lowerRightCornerLabel.frame.size.height)
    
  }

  
    override func draw(_ rect: CGRect) {
//      if let context = UIGraphicsGetCurrentContext() {
//        context.addArc(center: CGPoint(x: bounds.midX, y: bounds.midY), radius: 100.0, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
//        context.setLineWidth(5.0)
//        UIColor.green.setFill()
//        UIColor.red.setStroke()
//        context.strokePath()
//        context.fillPath() // fill 안됨 -> strokePath를 했을 때 경로를 없애며 그린다
//      }
      
//      let path = UIBezierPath()
//      path.addArc(withCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius: 100.0, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
//      path.lineWidth = 5.0
//      UIColor.green.setFill()
//      UIColor.red.setStroke()
//      path.stroke()
//      path.fill()
      
      let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
      roundedRect.addClip()
      UIColor.white.setFill()
      roundedRect.fill()
      
      if isFaceUp {
        if let faceCardImage = UIImage(named: rankString+suit) {
          faceCardImage.draw(in: bounds.zoom(by: SizeRatio.faceCardImageSizeToBoundsSize))
        } else {
//          drawPips()
        }
      } else {
        if let cardBackImage = UIImage(named: "cardback") {
          cardBackImage.draw(in: bounds)
        }
      }
    }
}

extension PlayingCardView {
  private struct SizeRatio {
    static let cornerFontSizeToBoundsHeight: CGFloat = 0.085
    static let cornerRadiusToBoundsHeight: CGFloat = 0.06
    static let cornerOffsetToCornerRadius: CGFloat = 0.33
    static let faceCardImageSizeToBoundsSize: CGFloat = 0.75 // 최대 크기의 75%
  }
  private var cornerRadius: CGFloat { // 높이를 비율과 곱하는 것
    return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeight
  }
  private var cornerOffset: CGFloat {
    return cornerRadius * SizeRatio.cornerOffsetToCornerRadius
  }
  private var cornerFontSize: CGFloat {
    return bounds.size.height * SizeRatio.cornerFontSizeToBoundsHeight
  }
  private var rankString: String {
    switch rank {
    case 1: return "A"
    case 2...10: return String(rank)
    case 11: return "J"
    case 12: return "Q"
    case 13: return "K"
    default: return "?"
    }
  }
}

extension CGRect {
  var leftHalf: CGRect {
    return CGRect(x: minX, y: minY, width: width/2, height: height)
  }
  var rightHalf: CGRect {
    return CGRect(x: midX, y: minY, width: width/2, height: height)
  }
  func inset(by size: CGSize) -> CGRect {
    return insetBy(dx: size.width, dy: size.height)
  }
  func sized(to size: CGSize) -> CGRect {
    return CGRect(origin: origin, size: size)
  }
  func zoom(by scale: CGFloat) -> CGRect {
    let newWidth = width * scale
    let newHeight = height * scale
    return insetBy(dx: (width - newWidth) / 2, dy: (height - newHeight) / 2)
  }
}

extension CGPoint {
  func offsetBy(dx: CGFloat, dy: CGFloat) -> CGPoint {
    return CGPoint(x: x + dx, y: y + dy)
  }
}
