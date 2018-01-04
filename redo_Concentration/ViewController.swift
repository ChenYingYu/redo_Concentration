//
//  ViewController.swift
//  redo_Concentration
//
//  Created by ChenAlan on 2017/12/17.
//  Copyright © 2017年 ChenAlan. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    
    @IBAction func touchCard(_ sender: UIButton) {
        if checkIfThemeIsChosen == 0 {
            chooseTheme(at: 1)
        }
        game.flipCount += 1
        flipCountLabel.text = "Flip: \(game.flipCount)"
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            scoreLabel.text = "Score: \(game.score)"
            updateViewFromModel()
        } else {
            print("chosen card was not in cardBottons")
        }
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.9818583131, green: 0.9282233715, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    var emojiChoices = [String]()
    
    var checkIfThemeIsChosen = 0
    
    func chooseTheme (at index: Int) {
        checkIfThemeIsChosen = 1
        let theme = ["sports": ["⚽️","🏀","🏈","⚾️","🎾","🏐"],
                     "cars": ["🚗","🚕","🚙","🚌","🚎","🏎"],
                     "halloween": ["👻","🎃","🍭","🍬","👿","🦇"],
                     "faces": ["😄","😇","😍","😎","🤠","🤡"],
                     "animals": ["🐶","🐭","🐹","🐼","🐸","🐷"],
                     "fruits": ["🍉","🍇","🍓","🍋","🥝","🍒"]]
        let themeKeys = Array(theme.keys)
        let themeIndex = Int(arc4random_uniform(UInt32(themeKeys.count)))
        emojiChoices = Array(theme.values)[themeIndex]
    }
    
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
        game.chosenBefore = Array(emoji.keys)
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    @IBAction func startNewGame(_ sender: UIButton) {
        game.flipCount = 0
        game.score = 0
        scoreLabel.text = "Score: 0"
        emojiChoices += emoji.values
        emoji = [Int:String]()
        for index in cardButtons.indices {
            let button = cardButtons[index]
            button.setTitle("", for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            game.cards[index].isFaceUp = false
            game.cards[index].isMatched = false
            game.indexOfOneAndOnlyFaceUpCard = nil
        }
        chooseTheme(at: 1)
    }
    
}


