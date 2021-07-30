//
//  ViewController.swift
//  Concentration
//
//  Created by Subin Kim on 2021/07/30.
//

import UIKit

class ViewController: UIViewController {
  
  var flipCount: Int = 0 {
    didSet {
      flipCountLabel.text = "Flips: \(flipCount)"
    }
  }

  @IBOutlet weak var flipCountLabel: UILabel!
  
  @IBOutlet var cardButtons: [UIButton]!
  
  var emojiChoices = ["👻", "🎃", "🎃", "👻"]
  
  @IBAction func touchCard(_ sender: UIButton) {
    flipCount += 1
    if let cardNumber = cardButtons.firstIndex(of: sender) {
      flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
      print("cardNumber = \(cardNumber)")
    } else {
      print("chosen card was not in cardButtons")
    }
  }

  @IBAction func touchSecondCard(_ sender: UIButton) {
    flipCount += 1
    flipCard(withEmoji: "🎃", on: sender)
  }
  
  func flipCard(withEmoji emoji: String, on button: UIButton) {
    if button.currentTitle == emoji {
      button.setTitle("", for: UIControl.State.normal)
      button.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
    } else {
      button.setTitle(emoji, for: UIControl.State.normal)
      button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
      }
}

