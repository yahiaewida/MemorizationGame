//
//  EmojiMemoryGame.swift
//  MemorizationGame
//
//  Created by Yahya Ewida on 9/2/20.
//  Copyright © 2020 Yahya Ewida. All rights reserved.
//

import Foundation

//MARK: Viewmodel

class EmojiMemoryGame : ObservableObject{
   @Published private var model : MemoryGame<String>
    
    private static func createMemoryGame(themeType : ThemeType) -> MemoryGame<String>{
        let randomNumber = Int.random(in: 2...5)
        let emojis = getThemeEmojis(themeType : themeType)
        return MemoryGame<String>(numberOfPairs: randomNumber) { pairIndex in
            emojis[pairIndex]
        }
    }
    init(themeType : ThemeType) {
        self.model = EmojiMemoryGame.createMemoryGame(themeType : themeType)
    }
    
    var cards : Array<MemoryGame<String>.Card>{
        model.cards
    }
    
    func choose(card : MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    private static func getThemeEmojis(themeType : ThemeType) -> [String] {
        switch themeType {
        case .Haloween:
            return ["👻","🎃","🕷","😂","😀"].shuffled()
        case .Sports:
            return ["⚽️","🏓","🏀","🎾","🎱"].shuffled()
        default: // Food
            return ["🍎","🍌","🍗","🍕","🍓"].shuffled()
        }
    }
}
