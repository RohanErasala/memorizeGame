//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Rohan Erasala on 5/22/20.
//  Copyright © 2020 Rohan Erasala. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    //private(set) makes it so that only this class can modify it, but all the other ones can see it
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    private static func createMemoryGame() -> MemoryGame<String> {
        
        let gameTheme = getRandomTheme()
        
        return MemoryGame<String>(gameTheme: gameTheme) { pairIndex in
            return gameTheme.icons[pairIndex]
        }
    }
    
    func newGame() {
        model = EmojiMemoryGame.createMemoryGame()
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    //MARK: - Intent(s)
    func choose(card: MemoryGame<String>.Card) {
        //objectWillChange.send()
        model.choose(card: card)
    }
    
    var themeName: String {
        model.gameTheme.name
    }
    
    var color: Color {
        model.gameTheme.color
    }
    
    var score: Int {
        model.score
    }
    
    static var emojiThemes: Array<MemoryGame<String>.theme> = [
        MemoryGame<String>.theme(name: "Sports", icons: ["🎾","🏀","🏈","⚾️","🏓"], size: 5, color: Color.blue),
        MemoryGame<String>.theme(name: "Flags", icons: ["🇺🇸","🇯🇵","🇪🇸","🇦🇷","🇨🇦"], size: 5, color: Color.green),
        MemoryGame<String>.theme(name: "Faces", icons: ["😂","😩","😤","😬","🤪"], color: Color.yellow)
    ]
    
    static func getRandomTheme() -> MemoryGame<String>.theme {
        return emojiThemes.randomElement()!
    }
}
