//
//  Card.swift
//  CardGame
//
//  Created by JieunKim on 03/07/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

class Card: CustomStringConvertible {
    private let suit: Suit, rank: Rank
    
    init(suit: Suit, rank: Rank) {
        self.suit = suit
        self.rank = rank
    }
    
    var description: String {
        return "\(suit)\(rank)"
    }
}

// Suits와 Ranks 둘 다 한정된 값이기 때문에 enum을 사용하는게 맞다고 판단하였습니다.
extension Card {
    enum Suit: Character, CustomStringConvertible, CaseIterable  {
        case spade = "\u{2660}"
        case heart = "\u{2665}"
        case diamond = "\u{2666}"
        case clovar = "\u{2663}"
        
        var description: String {
            return String(rawValue)
        }
    }
    
    enum Rank: Int, CustomStringConvertible, CaseIterable {
        case ace = 1, two, three, four, five, six, seven, eight, nine, ten, jack, queen, king
        
        var description: String {
            switch self {
            case .ace:
                return "A"
            case .jack:
                return "J"
            case .queen:
                return "Q"
            case .king:
                return "K"
            default:
                return String(rawValue)
            }
        }
    }
    func getRank() -> Rank {
        return rank
    }
    
    func getSuit() -> String {
        return String(suit.rawValue)
    }
}

extension Card.Rank: Comparable {
    static func < (lhs: Card.Rank, rhs: Card.Rank) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
    
    func isNextRank(_ card: Card.Rank) -> Bool {
        return self.rawValue + 1 == card.rawValue
    }
}

extension Card: Comparable {
    static func < (lhs: Card, rhs: Card) -> Bool {
        return lhs.rank < rhs.rank
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.rank == rhs.rank
    }
    
    static func == (lhs: Card, rhs: Int) -> Bool {
        return lhs.rank.rawValue == rhs
    }
    
    static func == (lhs: Int, rhs: Card) -> Bool {
        return lhs == rhs.rank.rawValue
    }
    
    static func + (lhs: Card, rhs: Int) -> Int {
        return lhs.rank.rawValue + rhs
    }
    
    static func + (lhs: Int, rhs: Card) -> Int {
        return lhs + rhs.rank.rawValue
    }
}

extension Card: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(rank)
    }
}
