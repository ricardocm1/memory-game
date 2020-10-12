//
//  MemoryGameTests.swift
//  MemoryGameTests
//
//  Created by Ricardo Carra Marsilio on 10/10/20.
//

import XCTest
import Quick
import Nimble

@testable import MemoryGame

class MemoryGameTests: QuickSpec {

    override
    func spec() {
        var game: MemoryGame!
        
        beforeEach {
            game = MemoryGame()
        }
        
        describe("when initialize game") {
            
            context("before begin to play") {
                
                it("should have 10 cards") {
                    expect(game.cards.count).to(equal(10))
                }
                
                it("should have zero cards found") {
                    expect(game.cardsFound.count).to(equal(0))
                }
                
                it("should have zero attempt cards") {
                    expect(game.attemptCards.count).to(equal(0))
                }
                
                it("should have endGame equals false") {
                    expect(game.endGame).to(beFalse())
                }
                
                it("should have zero attempts") {
                    expect(game.attempts).to(equal(0))
                }
            }
            
            context("and try 2 cards") {

                it("should increase attempts") {
                    game.attempt(cardIndex: 5)
                    game.attempt(cardIndex: 9)
                    
                    expect(game.attempts).to(equal(1))
                }
                
                it("should have cards in attempt cards or in found cards") {
                    game.attempt(cardIndex: 3)
                    game.attempt(cardIndex: 1)
                    
                    expect(game.attemptCards.count + game.cardsFound.count).to(equal(2))
                }
                
                it("should not end the game") {
                    game.attempt(cardIndex: 7)
                    game.attempt(cardIndex: 8)
                    
                    expect(game.endGame).to(beFalse())
                }
            }
        }
    }
}
