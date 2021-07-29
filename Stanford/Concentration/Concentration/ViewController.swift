//
//  ViewController.swift
//  Concentration
//
//  Created by Subin Kim on 2021/07/30.
//

import UIKit

class ViewController: UIViewController {

  @IBAction func touchCard(_ sender: UIButton) {
    flipCard(withEmoji: "👻", on: sender)
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

