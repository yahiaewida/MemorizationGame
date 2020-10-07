//
//  Cardify.swift
//  MemorizationGame
//
//  Created by Yahia Ewida on 10/6/20.
//  Copyright © 2020 Yahya Ewida. All rights reserved.
//

import SwiftUI

// make the content of the card of generic type for any view
struct Cardify : ViewModifier {
    private let cornerRadius : CGFloat = 10.0
    private let lineWidth : CGFloat = 3
    var isFaceUp : Bool
    
    func body(content: Content) -> some View {
        ZStack {
            if isFaceUp{
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke( lineWidth: lineWidth)
                content
            }else{
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.orange)
            }
        }.foregroundColor(Color.orange)
        
    }
}

extension View {
    func cardify(isFaceUp : Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
