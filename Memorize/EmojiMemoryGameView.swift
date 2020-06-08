//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Rohan Erasala on 5/21/20.
//  Copyright © 2020 Rohan Erasala. All rights reserved.
//


//lecture 1
import SwiftUI

//behaves like a view

struct EmojiMemoryGameView: View {
    //the type of this variable is any struct that behaves like a view
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack{
            
            Text("\(viewModel.themeName)")
                .font(.title)
                .padding(8)
            Text("Score: \(viewModel.score)")
                .padding(15)
                .background(Color.black)
                .foregroundColor(Color.white)
                .cornerRadius(10)

        Grid(items: viewModel.cards) { card in
            
                CardView(card: card).onTapGesture {
                    self.viewModel.choose(card: card)
                }
                    
        .padding(5)
            
            
        }.foregroundColor(viewModel.color)
            
        Button(action: {
            self.viewModel.newGame()
        }) {
            HStack {
                Text("New Game")
                    .fontWeight(.semibold)
                    .font(.title)
            }
            .padding()
            .background(Color.black)
            .foregroundColor(Color.white)
            .cornerRadius(10)
        }
            
        .foregroundColor(viewModel.color)
            .padding()
        }
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        
    GeometryReader { geometry in
        self.body(for: geometry.size)
         }
    }
    
    func body(for size: CGSize) -> some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: 3)
                Text(card.content)
            } else {
                if !card.isMatched {
                    RoundedRectangle(cornerRadius: cornerRadius).fill()
                }
            }
        } .aspectRatio(2/3, contentMode: .fit)
          .font(Font.system(size: fontSize(for: size)))
    }
    
    //MARK: - Drawing Constants
    
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3.0
    
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width,size.height) * 0.6
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}

//lecture 2

