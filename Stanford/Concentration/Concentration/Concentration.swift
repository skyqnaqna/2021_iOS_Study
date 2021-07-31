//
//  Concentration.swift
//  Concentration
//
//  Created by Subin Kim on 2021/07/31.
//

import Foundation

class Concentration {
  var cards = [Card]()
   
  func chooseCard(at index: Int) {
    if cards[index].isFaceUp {
      cards[index].isFaceUp = false
    } else {
      cards[index].isFaceUp = true
    }
  }
  
  init(numberOfPairsOfCards: Int) {
    for _ in 0 ..< numberOfPairsOfCards {
      let card = Card()
      cards += [card, card]
    }
    
    // TODO: Suffle the cards
  }
}
