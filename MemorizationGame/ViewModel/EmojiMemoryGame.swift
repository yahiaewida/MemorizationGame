//
//  EmojiMemoryGame.swift
//  MemorizationGame
//
//  Created by Yahya Ewida on 9/2/20.
//  Copyright © 2020 Yahya Ewida. All rights reserved.
//

import Foundation
import SwiftUI

//MARK: Viewmodel

class EmojiMemoryGame : ObservableObject{
    //MARK:- Variables
    @Published private var model : MemoryGame<String>
    @Published private(set) var count : Int
    private(set) var themeType : ThemeType
    
    
    var cards : Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    //MARK:- init
    init(themeType : ThemeType) {
        self.count = 0
        self.themeType = themeType
        self.model = EmojiMemoryGame.createMemoryGame(themeType : themeType)
    }
    
    //MARK:- Core Functions
    private static func createMemoryGame(themeType : ThemeType) -> MemoryGame<String>{
        let emojis = getThemeEmojis(themeType : themeType)
        let randomNumber = Int.random(in: 2...emojis.count)
        return MemoryGame<String>(numberOfPairs: randomNumber) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    func choose(card : MemoryGame<String>.Card) {
        let isValidMove = model.choose(card: card)
        if isValidMove {
            count += 1
        }
    }
    
    func resetFacedUpCard() {
        model.resetFacedUpCard() // Reset facedUpCardFirst because if not it will be obvious what is inside the card after reset
    }
    
    func resetGame() {
        count = 0        
        model = EmojiMemoryGame.createMemoryGame(themeType : themeType)
    }
    
    private static func getThemeEmojis(themeType : ThemeType) -> [String] {
        switch themeType {
        case .Haloween:
            return ["👻","🎃","🕷","😱","🤯","😈","🥶"].shuffled()
        case .Sports:
            return ["⚽️","🏓","🏀","🎾","🎱","🏸","🏐","🏄","⛳️","⛹️‍♀️","🥊","🤿","🏹","🥋"].shuffled()
        default: // Food
            return ["🍎","🍌","🍗","🍕","🍓","🍑","🍈","🍔","🥪","🥕","🥝"].shuffled()
        }
    }
}
