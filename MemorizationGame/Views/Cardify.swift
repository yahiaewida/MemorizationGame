//
//  Cardify.swift
//  MemorizationGame
//
//  Created by Yahia Ewida on 10/6/20.
//  Copyright © 2020 Yahya Ewida. All rights reserved.
//

import SwiftUI

// make the content of the card of generic type for any view
struct Cardify : AnimatableModifier {
    private let cornerRadius : CGFloat = 10.0
    private let lineWidth : CGFloat = 3
    var rotation : Double
    let color : Color
    var isFaceUp : Bool {
        rotation < 90
    }
    
    var animatableData: Double {
        get { return rotation }
        set { rotation = newValue  }
    }
    
    init(isFaceUp : Bool,color : Color) {
        self.color = color
        self.rotation = isFaceUp ? 0 : 180
    }
    
    func body(content: Content) -> some View {
        ZStack {
            Group{
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke( lineWidth: lineWidth)
                content
            }.opacity(isFaceUp ? 1 : 0)
            
            RoundedRectangle(cornerRadius: cornerRadius).fill(color)
                .opacity(isFaceUp ? 0 : 1)
            
        }
        .foregroundColor(color)
        .rotation3DEffect(Angle.init(degrees: rotation), axis: (0,1,0))
    }
}

extension View {
    func cardify(isFaceUp : Bool, color : Color) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp, color: color))
    }
}
