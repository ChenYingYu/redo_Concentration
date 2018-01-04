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
    
    @IBOutlet var newGameButton: [UIButton]!
    
    @IBOutlet var background: UIView!
    
    var alreadyChoseTheme = false
    
    @IBAction func touchCard(_ sender: UIButton) {
        if alreadyChoseTheme == false {
            chooseTheme()
            alreadyChoseTheme = true
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
    
    var colorOfButtons = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    var colorOfBackground = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    func updateViewFromModel() {
        let gameButton = newGameButton[0]
        gameButton.backgroundColor = colorOfButtons
        gameButton.setTitleColor(colorOfBackground, for: UIControlState.normal)
        flipCountLabel.textColor = colorOfButtons
        scoreLabel.textColor = colorOfButtons
        background.backgroundColor = colorOfBackground
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.9818583131, green: 0.9282233715, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : colorOfButtons
            }
        }
    }
    
    var emojiChoices = [String]()
    
    func chooseTheme () {
        let theme = ["sports": ["⚽️","🏀","🏈","⚾️","🎾","🏐"],
                     "cars": ["🚗","🚕","🚙","🚌","🚎","🏎"],
                     "halloween": ["👻","🎃","🍭","🍬","👿","🦇"],
                     "faces": ["😄","😇","😍","😎","🤠","🤡"],
                     "animals": ["🐶","🐭","🐹","🐼","🐸","🐷"],
                     "weather": ["☁️","❄️","🌙","⭐️","💧","⚡️"]]
        let themeBackgroundColor = ["sports": #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1),
                          "cars": #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1),
                          "halloween": #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
                          "faces": #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1),
                          "animals": #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1),
                          "weather": #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)]
        let themeColorOfCard = ["sports": #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
                                "cars": #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1),
                                "halloween": #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1),
                                "faces": #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1),
                                "animals": #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1),
                                "weather": #colorLiteral(red: 0.9818583131, green: 0.9282233715, blue: 1, alpha: 1)]
        
        let themeKeys = Array(theme.keys)
        let themeIndex = Int(arc4random_uniform(UInt32(themeKeys.count)))
        emojiChoices = Array(theme.values)[themeIndex]
        colorOfBackground = Array(themeBackgroundColor.values)[themeIndex]
        colorOfButtons = Array(themeColorOfCard.values)[themeIndex]
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
        flipCountLabel.text = "Flips: 0"
        game.score = 0
        scoreLabel.text = "Score: 0"
        emojiChoices += emoji.values
        emoji = [Int:String]()
        for index in cardButtons.indices {
            let button = cardButtons[index]
            button.setTitle("", for: UIControlState.normal)
            game.cards[index].isFaceUp = false
            game.cards[index].isMatched = false
            game.indexOfOneAndOnlyFaceUpCard = nil
        }
        chooseTheme()
        updateViewFromModel()
    }
    
}


