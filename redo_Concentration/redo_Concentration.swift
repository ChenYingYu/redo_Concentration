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
    
    func chooseCard(at index: Int) {
        if cards[index].isFaceUp{
           cards[index].isFaceUp = false
        } else{
            cards[index].isFaceUp = true
        }
    }
    
    init(numberOfPairsOfCards: Int){
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        //TODO Shuffle the cards
    }
}
