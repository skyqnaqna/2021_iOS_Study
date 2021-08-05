//
//  Concentration.swift
//  Concentration
//
//  Created by Subin Kim on 2021/07/31.
//

import Foundation

struct Concentration {
  private(set) var cards = [Card]()
  
  private var indexOfOneAndOnlyFaceUpCard: Int? {
    get {
      return cards.indices.filter { cards[$0].isFaceUp }.onAndOnly
      
      // extension 추가 전
//      let faceUpCardIndices = cards.indices.filter { cards[$0].isFaceUp }
//      return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil
      
      // 클로저 사용 전
//      var foundIndex: Int?
//      for index in cards.indices {
//        if cards[index].isFaceUp {
//          if foundIndex == nil {
//            foundIndex = index
//          } else {
//            return nil
//          }
//        }
//      }
//      return foundIndex
    }
    set {
      for index in cards.indices {
        cards[index].isFaceUp = (index == newValue)
      }
    }
  }
  
  mutating func chooseCard(at index: Int) {
    assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in cards")
    
    if !cards[index].isMatched {
      if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
        // check if cards match1
        if cards[matchIndex] == cards[index] {
          cards[matchIndex].isMatched = true
          cards[index].isMatched = true
        }
        cards[index].isFaceUp = true
//        indexOfOneAndOnlyFaceUpCard = nil
      } else {
        // either no cards or 2 cards are face up
//        for flipDownIndex in cards.indices {
//          cards[flipDownIndex].isFaceUp = false
//        }
//        cards[index].isFaceUp = true
        indexOfOneAndOnlyFaceUpCard = index
      }
    }
  }
  
  init(numberOfPairsOfCards: Int) {
    assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards")

    for _ in 0 ..< numberOfPairsOfCards {
      let card = Card()
      cards += [card, card]
    }
    
    // TODO: Suffle the cards
  }
}

extension Collection {
  var onAndOnly: Element? {
    return count == 1 ? first : nil
  }
}
