//
//  Card.swift
//  Concentration
//
//  Created by Subin Kim on 2021/07/31.
//

import Foundation

struct Card {
  var isFaceUp = false
  var isMatched = false
  var identifier: Int
  
  private static var identifierFactory = 0
  
  private static func getUniqueIdentifier() -> Int {
    identifierFactory += 1
    return identifierFactory
  }
  
  init() {
    self.identifier = Card.getUniqueIdentifier()
  }
}
