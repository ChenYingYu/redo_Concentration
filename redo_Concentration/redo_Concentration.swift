//
//  redo_Concentration.swift
//  redo_Concentration
//
//  Created by ChenAlan on 2017/12/19.
//  Copyright © 2017年 ChenAlan. All rights reserved.
//

import Foundation

class Concentration
{
    var cards =  [Card]()
    
    var flipCount = 0
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    var score = 0
    
    var chosenBefore = [Int]()
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                } else {
                    for chosenIdentifier in chosenBefore.indices {
                        if cards[index].identifier == chosenBefore[chosenIdentifier] || cards[matchIndex].identifier == chosenBefore[chosenIdentifier] {
                            score -= 1
                        }
                    }
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int){
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        //TODO: Shuffle the cards
        for _ in 1...cards.count {
            let randomIndex = Int (arc4random_uniform(UInt32(cards.count)))
            cards.swapAt(0, randomIndex)
        }
    }
}
