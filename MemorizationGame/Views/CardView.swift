//
//  CardView.swift
//  MemorizationGame
//
//  Created by Yahia Ewida on 10/11/20.
//  Copyright © 2020 Yahya Ewida. All rights reserved.
//

import SwiftUI

struct CardView : View{
    var card : MemoryGame<String>.Card
    var color : Color
    var body: some View{
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @State private var animatedBonusRemaining : Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    //View Builder would draw if the condition is true, otherwise would draw nothing
    @ViewBuilder
    private func body(for size: CGSize) -> some View{
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBonusRemaining*360-90), clockwise: true)
                            .onAppear() {
                                self.startBonusTimeAnimation()
                        }
                    } else {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-card.bonusRemaining*360-90), clockwise: true)
                    }
                }
                .padding(padding)
                .opacity(opacity)
                .transition(.identity)
                
                Text(self.card.content)
                    .font(Font.system(size: min(size.width, size.height) * fontScaleFactor))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: animationDuration).repeatForever(autoreverses: false) : .default)
            }
            .foregroundColor(self.color)
            .cardify(isFaceUp: self.card.isFaceUp, color: self.color)
            .transition(.scale)
        }
    }
    
    // MARK:- Constants
    private let fontScaleFactor : CGFloat = 0.7
    private let aspectRatio : CGFloat = 2/3
    private let opacity : Double  = 0.4
    private let padding : CGFloat = 5
    private let animationDuration : Double = 0.7
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: MemoryGame.Card(content: "Test", id: 0), color: Color.orange)
    }
}
