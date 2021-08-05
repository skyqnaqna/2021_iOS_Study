//
//  Card.swift
//  Concentration
//
//  Created by Subin Kim on 2021/07/31.
//

import Foundation

struct Card: Hashable {
  static func ==(lhs: Card, rhs: Card) -> Bool {
    return lhs.identifier == rhs.identifier
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(self.identifier)
  }
  
  var isFaceUp = false
  var isMatched = false
  private var identifier: Int
  
  private static var identifierFactory = 0
  
  private static func getUniqueIdentifier() -> Int {
    identifierFactory += 1
    return identifierFactory
  }
  
  init() {
    self.identifier = Card.getUniqueIdentifier()
  }
}
