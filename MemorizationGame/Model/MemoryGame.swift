//
//  MemoryGame.swift
//  MemorizationGame
//
//  Created by Yahya Ewida on 9/2/20.
//  Copyright © 2020 Yahya Ewida. All rights reserved.
//

import Foundation

// MARK: Model

struct MemoryGame<CardContent> where CardContent : Equatable{
    //MARK:- Variables
    private(set) var cards :[Card]
    private var indexOfFaceUpCard : Int?{
        get{ cards.indices.filter { cards[$0].isFaceUp }.only }
        set{
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
        
    //MARK:- init
    init(numberOfPairs : Int , cardContentFactory: (Int) -> CardContent) {
        cards = [Card]()
        for index in 0..<numberOfPairs{
            let content = cardContentFactory(index)
            cards.append(Card(content: content , id : index * 2))
            cards.append(Card(content: content,id : index * 2 + 1))
        }
    }
    
    //MARK:- Core Functions
    // Boolean returns true if it's new move and returns false if the same move repeated
    mutating func choose(card : Card) -> Bool{
        let index = cards.firstIndex(of: card)
        if let chosenIndex = index , !cards[chosenIndex].isFaceUp , !cards[chosenIndex].isMatched{
            if let faceUpIndex = indexOfFaceUpCard{
                if cards[chosenIndex].content == cards[faceUpIndex].content{
                    cards[chosenIndex].isMatched = true
                    cards[faceUpIndex].isMatched = true
                }
                cards[chosenIndex].isFaceUp = true
            }else{
                indexOfFaceUpCard = chosenIndex
            }
            return true
        }
        return false
    }
    
    mutating func resetFacedUpCard() {
        if let indexOfFaceUpCardValue = indexOfFaceUpCard {
            cards[indexOfFaceUpCardValue].isFaceUp = false
        }
    }
    
    struct Card : Identifiable{
        var isFaceUp = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        var content : CardContent
        var id: Int
        // bonus for quick matches
        
        var bonusTimeLimit: TimeInterval = 6
        
        private var faceUpTime : TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        var lastFaceUpDate : Date?
        var pastFaceUpTime : TimeInterval = 0
        var bonusTimeRemaining : TimeInterval {
            max(0,bonusTimeLimit - faceUpTime)
        }
        var bonusRemaining : Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining / bonusTimeLimit : 0
        }
        var hasEarnedBonus : Bool {
            isMatched && bonusTimeRemaining > 0
        }
        var isConsumingBonusTime : Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
        
    }
}
