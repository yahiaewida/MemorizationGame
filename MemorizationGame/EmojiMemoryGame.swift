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
   @Published private var model : MemoryGame<String> = createMemoryGame()
    
    private static func createMemoryGame() -> MemoryGame<String>{
        let randomNumber = Int.random(in: 2...5)
        let emojis = ["👻","🎃","🕷","😂","😀"].shuffled()
        return MemoryGame<String>(numberOfPairs: randomNumber) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    var cards : Array<MemoryGame<String>.Card>{
        model.cards
    }
    
    
    func choose(card : MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}
