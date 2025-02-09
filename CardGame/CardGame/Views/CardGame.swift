//
//  CardGame.swift
//  CardGame
//
//  Created by JieunKim on 05/07/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

protocol OutputViewPrintable {
    func printPlayerInfo(handler: (String, String) -> ())
}

class CardGame: OutputViewPrintable {
    private var players = [PokerPlayer]()
    private var dealer: Dealer
    private let gameMode: CardGameMode
    private let numberOfPlayers: Int
    var collectionCards = [Card: Int]()
 
    func printPlayerInfo(handler: (String, String) -> ()) {
        players.forEach { player in handler(player.name, String(describing: player.hand))}
    }
    
    func winner() -> PokerPlayer  {
        let winner = players.max()!
        return winner
    }
    
    init(dealer: Dealer, gameMode: CardGameMode, numberOfPlayers: Int) {
        self.dealer = dealer
        self.gameMode = gameMode
        self.numberOfPlayers = numberOfPlayers
    }
    
    func gameStart() {
        guard continueGame() else { return }
        reset()
        setPlayer()
        setCards()
    }
    
    func continueGame() -> Bool {
        //numberOfCards, requirement는 둘다 enum 타입이라 내부에서 연산을 하지 안고 밖에서 하는게 더 낫다고 판단하였습니다.
        let numberOfCards = gameMode.numberOfCards
        let requirement = numberOfCards * (numberOfPlayers + 1)
        return dealer.haveCards(requirement: requirement)
    }
    
    private func reset() {
    self.players.forEach{$0.hand.clear()}
    }
    
    private func setPlayer() {
        players.removeAll()
        for order in 1...self.numberOfPlayers {
            players.append(PokerPlayer(number: order, name: "참가자"))
        }
        players.append(dealer as! PokerPlayer)
    }
    
    private func setCards() {
        let numberOfCards = gameMode.numberOfCards
        
        for  _ in 1...numberOfCards {
            for player in players {
                guard let card = self.dealer.give() else {
                    return
                }
                player.receive(newCards: card)
            }
        }
    }
}
