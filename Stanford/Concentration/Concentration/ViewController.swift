//
//  ViewController.swift
//  Concentration
//
//  Created by Subin Kim on 2021/07/30.
//

import UIKit

class ViewController: UIViewController {
  
  private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
  
  var numberOfPairsOfCards: Int {
    get {
      return (cardButtons.count + 1) / 2
    }
  }
  
  private(set) var flipCount: Int = 0 {
    didSet {
      updateFlipCountLabel()
    }
  }
  
  private func updateFlipCountLabel() {
    let attributes: [NSAttributedString.Key:Any] = [
      .strokeColor : #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1),
      .strokeWidth : 5.0
    ]
    let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
    flipCountLabel.attributedText = attributedString
  }

  @IBOutlet private weak var flipCountLabel: UILabel! {
    didSet {
      updateFlipCountLabel()
    }
  }
  
  @IBOutlet private var cardButtons: [UIButton]!
  
  
  @IBAction private func touchCard(_ sender: UIButton) {
    flipCount += 1
    if let cardNumber = cardButtons.firstIndex(of: sender) {
      game.chooseCard(at: cardNumber)
      updateViewFromModel()
    } else {
      print("chosen card was not in cardButtons")
    }
  }
  
  private func updateViewFromModel() {
    for index in cardButtons.indices {
      let button = cardButtons[index]
      let card = game.cards[index]
      if card.isFaceUp {
        button.setTitle(emoji(for: card), for: UIControl.State.normal)
        button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
      } else {
        button.setTitle("", for: UIControl.State.normal)
        button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
      }
    }
  }
  
  private var emojiChoices = ["👻", "🎃", "😈", "😺", "👺", "🍎", "🍭", "🦇", "🐶"]

  private var emoji = [Card:String]()

  private func emoji(for card: Card) -> String {
    if emoji[card] == nil, emojiChoices.count > 0 {
//      let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
      emoji[card] = emojiChoices.remove(at: emojiChoices.count.arc4random)
    }
    return emoji[card] ?? "?"
  }
}

extension Int {
  var arc4random: Int {
    if self > 0 {
      return Int(arc4random_uniform(UInt32(self)))
    } else if self < 0 {
      return Int(arc4random_uniform(UInt32(abs(self))))
    } else {
      return 0
    }
  }
}
