//
//  CardsThemeView.swift
//  MemorizationGame
//
//  Created by Yahia Ewida on 10/11/20.
//  Copyright © 2020 Yahya Ewida. All rights reserved.
//

import SwiftUI

struct CardsThemeView: View {
    @ObservedObject var viewModel : EmojiMemoryGame
    
    var body: some View {
        VStack {
            Text(viewModel.themeType.rawValue)
                .fontWeight(.semibold)
                .font(.title)
            
            GridView(viewModel.cards){ card in
                CardView(card: card).onTapGesture {
                    withAnimation(.linear(duration: self.animationDuration)) {
                        self.viewModel.choose(card: card)
                    }
                }.padding(self.padding)
            }.padding()
            
            Text("Score : \(viewModel.count)")
                .fontWeight(.semibold)
                .font(.title)
                .padding(padding)
            
            Button(action: {
                self.viewModel.resetFacedUpCard()
                withAnimation(.easeInOut(duration: self.animationDuration)) {
                    self.viewModel.resetGame()
                }
            }) {
                Text("Reset Game")
                    .fontWeight(.semibold)
                    .font(.headline)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.red.opacity(opacity))
                    .cornerRadius(cornerRadius)
                    .padding(padding)
            }
        }        
    }
    
    // MARK:- Constants
    private let padding : CGFloat = 5
    private let cornerRadius : CGFloat = 40
    private let opacity : Double = 0.7
    private let animationDuration : Double = 0.7
}

struct CardsThemeView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame(themeType: .Sports)
        game.choose(card: game.cards[0])
        return CardsThemeView(viewModel: game)
    }
}
