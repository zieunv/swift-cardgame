//
//  Player.swift
//  CardGame
//
//  Created by joon-ho kil on 5/27/19.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Player: Participant {
    private let name: String
    private var cards = [Card]()
    
    init(name: String, cards: [Card]){
        self.name = name
        self.cards = cards
    }
    
    func getName() -> String {
        return name
    }
    
    func getCards() -> [Card] {
        return cards
    }
    
    func getScore() -> Int {
        
        
        return checkEqualRankCount()
    }
    
    private func checkEqualRankCount () -> Int {
        var maxCount = 0
        for card in cards {
            let sameCardCount = getSameCardCount(card, cards)
            if sameCardCount > maxCount {
                maxCount = sameCardCount
            }
        }
        
        return maxCount
    }

    private func getSameCardCount (_ card: Card, _ cards: [Card]) -> Int {
        var equalRankCount = 0
        
        for cardCompared in cards {
            equalRankCount = addCountIfSameCard (cards: (card, cardCompared), count: equalRankCount)
        }
        
        return equalRankCount
    }

    private func addCountIfSameCard (cards: (Card, Card), count: Int) -> Int {
        if cards.0.equalRank(cards.1) {
            return count+1
        }
        
        return count
    }
}
