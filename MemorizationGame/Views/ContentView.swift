//
//  ContentView.swift
//  MemorizationGame
//
//  Created by Yahya Ewida on 9/2/20.
//  Copyright © 2020 Yahya Ewida. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel : EmojiMemoryGame
    var body: some View {
        
        GridView(viewModel.cards){ card in
            CardView(card: card).onTapGesture {
                self.viewModel.choose(card: card)
            }.padding(5)
        }.padding()
    }
    
    
}

struct CardView : View{
    var card : MemoryGame<String>.Card
    var body: some View{
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    //View Builder would draw if the condition is true, otherwise would draw nothing
    @ViewBuilder
    private func body(for size: CGSize) -> some View{
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(110-90), clockwise: true).padding(5).opacity(0.4)
                Text(self.card.content)
            }.font(Font.system(size: min(size.width, size.height) * fontScaleFactor))
                .foregroundColor(Color.orange)
                .cardify(isFaceUp: self.card.isFaceUp)
        }
    }
    
    // MARK:- Constants
    private let fontScaleFactor : CGFloat = 0.7
    private let aspectRatio : CGFloat = 2/3
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return ContentView(viewModel: game)
    }
}
