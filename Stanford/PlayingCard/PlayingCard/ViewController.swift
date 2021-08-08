//
//  ViewController.swift
//  PlayingCard
//
//  Created by Subin Kim on 2021/08/07.
//

import UIKit

class ViewController: UIViewController {

  var deck = PlayingCardDeck()
  
  override func viewDidLoad() {
    super.viewDidLoad()

    for _ in 1 ... 10 {
      if let card = deck.draw() {
        print("\(card)")
      }
    }
  }


}

