//
//  PlayingCardView.swift
//  PlayingCard
//
//  Created by Subin Kim on 2021/08/08.
//

import UIKit

class PlayingCardView: UIView {
  
  var rank: Int = 5
  var suit: String = "❤️"
  var isFaceUp: Bool = true
  
  private func centeredAttributedString(_ string: String, fontSize: CGFloat) -> NSAttributedString {
    var font = UIFont.preferredFont(forTextStyle: .body).withSize(fontSize)
    font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font) // 아이폰 설정 -> 디스플레이 및 밝기 -> 텍스트 크기 -> 유동적 글자 크기 조절 지원
    
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .center
    
    return NSAttributedString(string: string, attributes: [NSAttributedString.Key.paragraphStyle:paragraphStyle, .font:font])
  }
  
  private var cornerString: NSAttributedString {
    return centeredAttributedString(rank+"\n"+suit, fontSize: 0.0)
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
      
      let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: 16.0)
      roundedRect.addClip()
      UIColor.white.setFill()
      roundedRect.fill()
      
    }
}
