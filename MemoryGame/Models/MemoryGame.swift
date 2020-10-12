//
//  MemoryGame.swift
//  MemoryGame
//
//  Created by Ricardo Carra Marsilio on 11/10/20.
//

import Foundation

class MemoryGame {
    internal init() {
        var cards:[Card] = []
        
        for image in cardsDefault {
            cards.append(Card(id: 1, image: image))
            cards.append(Card(id: 2, image: image))
        }
        
        self.cards = cards.shuffled()
    }
    
    var cards: [Card]
    private(set) var attempts: Int = 0
    private(set) var cardsFound: [Card] = [] {
        didSet {
            if cards.count == cardsFound.count {
                endGame = true
            }
        }
    }
    private(set) var attemptCards: [Card] = []
    private(set) var endGame: Bool = false
    var isShowingCards = false
    
    func attempt(cardIndex: Int) {
        if !self.attemptCards.contains(where: { card in return self.cards[cardIndex].identifier == card.identifier }) && !self.cardsFound.contains(where: { card in return self.cards[cardIndex].identifier == card.identifier }) {
            self.attemptCards.append(self.cards[cardIndex])
            self.cards[cardIndex].show = true
        }
        
        if self.attemptCards.count == 2 {
            self.attempts += 1
            
            if self.attemptCards[0].image == self.attemptCards[1].image {
                self.cardsFound.append(contentsOf: self.attemptCards)
                self.attemptCards = []
            }
        }
    }
    
    func resetAttemptCards() {
        self.attemptCards.forEach({ card in
            card.show = false
        })
        
        self.attemptCards = []
    }
}

var cardsDefault = [
    "Card Anão",
    "Card Bruxa",
    "Card Cavaleiro",
    "Card Elfa",
    "Card Mago"
]

extension MemoryGame {
    class func newGame() -> MemoryGame {
        return MemoryGame()
    }
}
