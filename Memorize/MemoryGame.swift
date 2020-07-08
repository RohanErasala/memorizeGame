//
//  MemoryGame.swift
//  Memorize
//
//  Created by Rohan Erasala on 5/22/20.
//  Copyright © 2020 Rohan Erasala. All rights reserved.
//

import Foundation
import SwiftUI

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    var gameTheme: theme
    var score: Int = 0
    var unshuffledCards: Array<Card>
    
    /*var onlyFaceUpCard: Int? {
        get { cards.indices.filter { index in cards[index].isFaceUp }.only }
        
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    mutating func choose(card: Card) {
        print("card chosen: \(card)")
        
        if let chosenIndex: Int = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = onlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    
                    score += 2
                } else {
                    self.cards[chosenIndex].hasBeenSeen = true
                }
                
                self.cards[chosenIndex].isFaceUp = true

            } else {
                
                onlyFaceUpCard = chosenIndex
                self.cards[chosenIndex].hasBeenSeen = true
            }
        }
    }*/
    
    private var round = Array<Card>()
    
    mutating func choose(card: Card) {
        print("card chosen: \(card)")
        
        if round.count == 2 {
            cards[index(of: round[0])].isFaceUp = false
            cards[index(of: round[1])].isFaceUp = false
            round.removeAll()
        }
        
        round.append(card)
        let last: Int = round.count - 1
        
        cards[index(of: round[last])].isFaceUp = true
        
        if round.count == 2 {
            if round[0].content == round[1].content {
                cards[index(of: round[0])].isMatched = true
                cards[index(of: round[1])].isMatched = true
                score += 2
            } else {
                score -= cards[index(of: round[0])].hasBeenSeen.intValue
                score -= cards[index(of: round[1])].hasBeenSeen.intValue
            }
            
            cards[index(of: round[0])].hasBeenSeen = true
            cards[index(of: round[1])].hasBeenSeen = true
        }
    }
    
    func index(of: Card)-> Int {
        for index in 0..<self.cards.count {
            if self.cards[index].id == of.id {
                return index
            }
        }
        
        return -1 // TODO: fix!
    }
    
    init(gameTheme: theme, cardContentFactory: (Int) -> CardContent){
        
        self.gameTheme = gameTheme
        
        cards = Array<Card>()
        var size: Int? = gameTheme.size
        
        if size == nil {
            size = Int.random(in: 2...gameTheme.icons.count)
        }
        
        for pairIndex in 0..<size! {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        
        unshuffledCards = cards
        cards = cards.shuffled()
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched: Bool = false
        var hasBeenSeen: Bool = false
        //we don't care what's on the card
        var content: CardContent
        var id: Int
        
        //MARK: - Bonus Time
        
        var bonusTimeLimit: TimeInterval = 6
        
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        var lastFaceUpDate: Date?
        
        var pastFaceUpTime: TimeInterval = 0
        
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }
        
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        var isConsumingBonusTime: Bool {
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
    
    struct theme {
        var name = String()
        var icons = Array<String>()
        var size: Int?
        var color: Color
        
        init(name: String, icons: Array<String>, size: Int, color: Color){
            self.name = name
            self.icons = icons
            self.size = size
            self.color = color
        }
        
        init(name: String, icons: Array<String>, color: Color){
            self.name = name
            self.icons = icons
            self.size = nil
            self.color = color
        }
    }
    
    
}
