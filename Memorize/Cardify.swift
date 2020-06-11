//
//  Cardify.swift
//  Memorize
//
//  Created by Rohan Erasala on 6/10/20.
//  Copyright © 2020 Rohan Erasala. All rights reserved.
//

import SwiftUI

struct Cardify: ViewModifier {
    
    var isFaceUp: Bool
    
    func body(content: Content) -> some View {
        
        ZStack{
            if isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: 3)
                content
            } else {
                RoundedRectangle(cornerRadius: cornerRadius).fill()
        }
        }
        
        
    }
    
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3.0
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
